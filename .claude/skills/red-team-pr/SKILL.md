---
name: red-team-pr
description: Use right after opening a PR in this repo (any `gh pr create`), when a subagent hands you a PR or branch it implemented for you, or when the user asks for a subagent review or red-team ("review / redteam") of a PR or branch, including a contributor's PR.
argument-hint: "[PR number or branch]"
---

# Red-team a PR

Every PR Claude opens gets an adversarial review from a fresh subagent before it goes back to the maintainer. The author writes the reviewer a brief, the reviewer tries to break the change, and the author answers every finding. The PR stays a draft until then (`AGENTS.md`). The maintainer then sees the findings and the answers, and decides whether to mark it ready.

A fresh reviewer hasn't seen your reasoning, so it doesn't share your blind spots. What it finds depends on the brief: told only "review PR #N", it reads the diff without knowing what must hold or what you claimed.

Target: $ARGUMENTS (if empty, the PR you just opened).

## When

- Right after `gh pr create`. A hook in `.claude/settings.json` reminds you.
- A local branch the user wants reviewed before it becomes a PR. Commit it first: the reviewer reads commits, not your working tree.
- A PR or branch a subagent implemented for you. Wait until the implementer has finished, then brief the reviewer and answer the findings as the author.
- If you are a subagent, don't run it: give the PR URL in your final report. The session that launched you runs the review, since it has the user and reports to them.
- A contributor's PR, when the user asks: do steps 1 and 3 only. Report the findings; don't push to their branch, comment on the PR or approve it.

A PR that only bumps the version and dates the changelog for a release needs no review. Scale the brief to the PR: a one-line docs fix needs a few lines of background, not a page.

## 1. Brief the reviewer

If a PR you're the author of isn't a draft, and the user didn't ask for it ready, convert it first with `gh pr ready <N> --undo`. Then launch an `Agent` with:

- `subagent_type: "general-purpose"`;
- `isolation: "worktree"`, so the reviewer can run code and try mutations in its own checkout;
- `run_in_background: true`, if your `Agent` tool has that parameter (in the Claude desktop app, subagents always run in the background);
- `model` set to the family you are running on (for example `"opus"`). Left out, it can fall back to a configured default subagent model, which may be smaller;
- description `Red-team PR #<N>`.

Tell the user the review is running. Leave the branch alone until it's back, so you and the reviewer read the same head.

The brief has the six parts below, in this order. Parts 2 and 3 are where a brief succeeds or fails: they hold what the reviewer can't get from the diff.

### Part 1: Role

"You are a senior fish shell engineer acting as an adversarial reviewer (red team) for a pull request to Tide, a fish prompt. Find real defects before it merges: things that are wrong, slower, untested, unportable or hard to read. Try hard to break it, then give a calibrated verdict."

### Part 2: The change

- The PR number, title and author.
- The head SHA and the base, from `gh pr view <N> --json baseRefName,headRefOid`. The base is the merge-base with the PR's base branch, not that branch's tip, which would show its newer commits reversed. Get it from GitHub, which works in any clone: `gh api repos/IlanCosman/tide/compare/<baseRefName>...<head> --jq .merge_base_commit.sha`.
- How to get the head: `git fetch https://github.com/IlanCosman/tide.git pull/<N>/head`. It works for a PR from a fork, and in a clone whose `origin` is a fork.
- The commands to read it: `git diff <base>...<head>` and `gh pr view <N> --repo IlanCosman/tide`.
- The files touched, a phrase each.
- If there was an earlier review round: its findings and your answers. The reviewer may challenge an answer, but shouldn't re-raise a finding unless the answer is wrong.

### Part 3: Background and requirements

- What the surrounding code does, and who calls it (for an item: `_tide_1_line_prompt` or `_tide_2_line_prompt`, run by the background worker that `functions/fish_prompt.fish` starts; for configuration: `tide configure` and the universal variables it sets).
- The PR's intent, as numbered properties that must hold. Include "behaves exactly as before" for every path the PR should leave alone.
- The evidence you are claiming (test runs, manual checks, timings), so the reviewer can challenge it.
- For a contributor's PR, especially an old one: what has changed on `main` since it was opened, and the issue it claims to fix.

### Part 4: Angles

The specific ways you think it could break, as questions, then "and anything else you find". Defects you already know about go in their own "Already known" line, so the reviewer doesn't spend time on them. Always include:

- **Premise and design:** is this the right problem and the right fix? Is there a materially simpler or more robust design? Does `main`, a release since, or another open PR already fix it?
- **Fish compatibility:** does it use a builtin, flag or syntax newer than the oldest fish the wiki's [fish version compatibility][] table lists for the current release?
- **macOS and Linux:** does it call external tools whose flags differ between BSD and GNU (`sed`, `date`, `stat`, `mktemp`, `find`)?
- **Prompt cost:** does it add external commands, subshells or file reads to every prompt? A tool-specific item belongs in `_tide_remove_unusable_items`'s list rather than checking for its tool on every prompt.
- **Universal variables:** does it rename or remove a user-facing `tide_*` variable, need a default for existing installs in `_tide_init_update`, or leave variables behind that `_tide_init_uninstall` doesn't erase?
- **Every mode it touches:** lean, classic and rainbow styles; 16 colors and true color; one and two line prompts; transient prompt; vi key bindings.
- **Tests:** do they test what they claim? Would they fail if the change were reverted or broken?
- **Readability and style:** naming, structure, comments that explain why. Trivial nits go under Minor.
- **Conventions:** read `AGENTS.md` and `CONTRIBUTING.md`.

### Part 5: Rules

- You run in your own git worktree. Note its branch (`git branch --show-current`), then check out the head with `git switch --detach <head>`. Throwaway edits are fine, such as a mutation to see whether a test catches it; revert them before you finish.
- Never run a bare `make`, `make install` or `make test`, `fisher install` or `funcsave`: they write into the user's real fish config. Run the tests with `env XDG_CONFIG_HOME="$(mktemp -d)" make test`, and try code under the same kind of throwaway config. If your tool permissions refuse that command, say the tests weren't run and rely on CI's results (`gh pr checks <N>`); don't look for another way to run them.
- As your last step, after your last read of the PR's files: stop any background command, revert your edits, delete any file you added, run `git switch <the branch you noted>`, and check that `git status --porcelain` prints nothing. Say in your report which branch you ended on and whether the status was empty.
- That step matters because Claude Code removes your worktree when you finish only if it's clean and its HEAD has no commits its starting point lacks, and the PR's head has such commits.
- Read-only toward everything shared: no commits, pushes, GitHub comments, reviews or approvals, and no changes to any other checkout or to the user's fish config.
- Do all the review yourself: no subagents.
- Never read credential files (`.env`, `.ssh/`, `.aws/` and the like).
- For every claim, say whether you verified it (ran it, read the source) or inferred it. Speculative findings are welcome if labelled, with the experiment that would settle them.

### Part 6: Output format

Paste this verbatim:

```markdown
### Strengths

What you checked and found sound, one line each, so the author knows what
you covered.

### Issues

Grouped as **Critical (must fix)**, **Important (should fix)**,
**Minor (nice to have)**. For each:

- file:line, or "design" for a finding about the PR as a whole
- what's wrong, with a concrete failure scenario (inputs/state -> wrong
  prompt, error, hang, slowdown, or a misled reader)
- verified or inferred, and how
- how to fix it

### Experiments for the author

Checks you couldn't run here (another OS, an older fish, a real terminal),
as exact steps.

### Declined to judge

Anything you considered and set aside, one line each, with the reason.

### Assessment

**Ready to merge?** Yes / No / With fixes, then 1-2 sentences of reasoning.
```

## 2. Answer every finding

Skip this step for a contributor's PR: the findings go to the user in step 3.

The reviewer can be wrong. Check each claim against the code, or run it, before you act on it. Then give every finding, Minor and style ones included, one of these answers:

- **Fixed.** For a bug littlecheck can reach, add a test that fails without the fix: revert the fix locally and watch the test fail.
- **Pushed back,** with evidence: the code path, a measurement, the experiment you ran.
- **Open,** saying what it needs:
  - the user's decision (a different premise, a redesign, or a change to Tide's public interface `AGENTS.md` says to ask about): give the options and your recommendation, and don't implement it;
  - an experiment you can't run, such as one on the other OS;
  - a follow-up outside this PR's scope: list it for the user (in the desktop app, offer it as a new task).

Run the reviewer's experiments for the author if you can. Then run `make fmt`, `make lint` and the isolated tests, commit and push the fixes to the PR branch, and update the PR title and description to match the new diff. If a fix changed the design rather than patching it, launch a fresh reviewer on the new head, with this round's findings and your answers in part 2 of its brief.

When every finding has its answer, end the description with one line recording the review, so whoever marks the PR ready can see how it came out:

```text
Red-team: SAFE (red-team-pr, <date>)
Red-team: FIXED: uvar left after uninstall, GNU-only sed flag (red-team-pr, <date>)
```

`SAFE` when every finding was pushed back or there were none; `FIXED:` and a few words per fix otherwise. While a finding is still **Open**, say so in the body, and write the line once it's settled; a follow-up listed for a later PR counts as settled. After a later round, rewrite the line to cover all rounds.

## 3. Report to the user

1. The PR link, whether it's a draft, and its CI status.
2. **Verdict:** the reviewer's assessment, and which of the "must hold" properties it confirmed.
3. For your own PR, a `Finding | Response` table, one row per finding (related Minor ones may share a row). Each response starts with **Fixed**, **Pushed back** or **Open**, then says what you did or why. For a contributor's PR, the findings themselves, each with your own check of whether it holds.
4. What's left for the user: decisions, and experiments you couldn't run.

Marking the PR ready and merging it are the maintainer's call, unless they asked you to do it. Review `gh pr diff` before you mark it ready.

## Common mistakes

| Mistake                                        | Instead                                                    |
| ---------------------------------------------- | ---------------------------------------------------------- |
| Diffing from the base branch's tip             | Diff from the merge-base: `git diff <base>...<head>`       |
| "No style nits" in the brief                   | Style is in scope; nits go under Minor                     |
| Accepting every finding                        | Verify first; push back with evidence when it's wrong      |
| Implementing a redesign the reviewer suggested | Open, with options and your recommendation for the user    |
| Running `make test` without a throwaway config | `env XDG_CONFIG_HOME="$(mktemp -d)" make test`             |
| Pushing fixes to a contributor's branch        | Report the findings; the maintainer decides what goes back |
| No `Red-team:` line at the end of the PR body  | Add it once every finding is answered                      |

[fish version compatibility]: https://github.com/IlanCosman/tide/wiki/Fish-version-compatibility
