"""PostToolUse hook that notes a newly opened PR still needs its red-team review.

Wired in `.claude/settings.json` on `Bash(gh pr create *)`. That `if` filter
also lets through every command containing `$()`, backticks or `$VAR`, so the
hook checks for itself that the command ran `gh pr create` (not `--dry-run`)
and that the last line it printed is a Tide PR URL, as `gh pr create` does.

A subagent's tool calls carry `agent_id`. The review is then left to the
session that launched the subagent, which has the user and reports to them.

Standard library only, and Python 3.9 compatible: macOS ships 3.9 as
`/usr/bin/python3`. Input it doesn't expect makes it print nothing.
"""

from __future__ import annotations

import json
import re
import sys

# `gh pr create` at the start of a command, not inside an argument like `echo`'s
_CREATES_PR = re.compile(r"(?:^|[;&|(\n])\s*gh pr create\b")
_DRY_RUN = re.compile(r"\s--dry-run\b")
_PR_URL = re.compile(r"https://github\.com/IlanCosman/tide/pull/\d+", re.IGNORECASE)


def note_for(event: object) -> str | None:
    """Return the context to add after this Bash call, or None if no PR opened."""
    if not isinstance(event, dict):
        return None
    tool_input = event.get("tool_input")
    command = tool_input.get("command") if isinstance(tool_input, dict) else None
    if not isinstance(command, str) or not _CREATES_PR.search(command) or _DRY_RUN.search(command):
        return None
    response = event.get("tool_response")
    stdout = response.get("stdout") if isinstance(response, dict) else None
    if not isinstance(stdout, str):
        return None
    lines = stdout.strip().splitlines()
    url = _PR_URL.fullmatch(lines[-1].strip()) if lines else None
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
    try:
        event = json.loads(sys.stdin.buffer.read().decode("utf-8"))
    except ValueError:  # Invalid JSON or UTF-8 (UnicodeDecodeError is a ValueError)
        return
    note = note_for(event)
    if note is not None:
        output = {"hookEventName": "PostToolUse", "additionalContext": note}
        sys.stdout.write(json.dumps({"hookSpecificOutput": output}) + "\n")


if __name__ == "__main__":
    main()
