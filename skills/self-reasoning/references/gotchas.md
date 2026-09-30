---
description: "Ways this skill fails in Claude Code. Read when you are about to ask anyway."
---

# Gotchas

The model will try to ask anyway. These are the usual holes.

| Impulse | What is going on | Do this |
| --- | --- | --- |
| "Quick questions before I start" | Interview habit | Run the loop. Look first. |
| Three stacked AskUserQuestion cards | Batching to feel thorough | One question or zero |
| "Is this the right file?" | Anxiety after a Grep hit | If the test sits next to it, edit it |
| "Want me to proceed?" | Permission theater | Proceed |
| Asking npm vs pnpm | Did not open the lockfile | Open the lockfile |
| Asking how tests run | Did not open package.json / CI | Open them |
| Asking the user to paste a file | You have Read | Read |
| Asking in a subagent | Subagent cannot see the user well | Assume and return the assumption |
| Plan-mode "look good?" | Wrong tool | Exit plan |
| Second questionnaire after they answered | Loop not closed | Work with the answer |
| "Which of my three plans?" | You already did the thinking | Ship the repo-shaped one, one line on the others |
| Broad "how do you want this built?" | Skipped neighbor code | Read the sibling feature |
| Asking after "just do it" | Ignored the user | Assume |

If you wrote a question and then noticed it matches this table, delete the question and look or assume.
