"""PostToolUse hook that notes a newly opened PR still needs its red-team review.

Wired in `.claude/settings.json` on `Bash(gh pr create *)`. That `if` filter
also lets through every command containing `$()`, backticks or `$VAR`, so the
hook checks for itself that the command ran `gh pr create` and printed a Tide
PR URL.

A subagent's tool calls carry `agent_id`. The review is then left to the
session that launched the subagent, which has the user and reports to them.

Standard library only, and Python 3.9 compatible: macOS ships 3.9 as
`/usr/bin/python3`.
"""

from __future__ import annotations

import json
import re
import sys

_CREATES_PR = re.compile(r"(?:^|[\s;&|(])gh pr create\b")
_PR_URL = re.compile(r"https://github\.com/IlanCosman/tide/pull/\d+", re.IGNORECASE)


def note_for(event: dict) -> str | None:
    """Return the context to add after this Bash call, or None if no PR opened."""
    command = event.get("tool_input", {}).get("command", "")
    if not _CREATES_PR.search(command):
        return None
    response = event.get("tool_response")
    stdout = response.get("stdout", "") if isinstance(response, dict) else ""
    url = _PR_URL.search(stdout)
    if url is None:
        return None
    if "agent_id" in event:
        return (
            f"`gh pr create` opened {url[0]} inside a subagent. The session that"
            " launched this subagent runs the PR's red-team review (the"
            " `red-team-pr` skill), so the final report needs to give the PR URL."
        )
    return (
        f"`gh pr create` opened {url[0]}. In this repo every PR Claude opens gets"
        " a red-team review from a fresh subagent before it goes back to the"
        " user (the `red-team-pr` skill, `.claude/skills/red-team-pr/SKILL.md`)."
        " This PR's review hasn't started."
    )


def main() -> None:
    note = note_for(json.load(sys.stdin))
    if note is not None:
        output = {"hookEventName": "PostToolUse", "additionalContext": note}
        sys.stdout.write(json.dumps({"hookSpecificOutput": output}) + "\n")


if __name__ == "__main__":
    main()
