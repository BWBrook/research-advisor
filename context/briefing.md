# Context for the continuing adviser

This briefing is a synthesis of the original design conversation. It records Barry's account and the approach initially developed; it does not independently verify the state of any scientific repository. For exact wording and the original first prompts, see [conversation.md](conversation.md). Current per-project execution state lives under `projects/<slug>/STATE.md` (for example, [projects/rc-dates/STATE.md](../projects/rc-dates/STATE.md)).

## Why this experiment exists

Barry Brook is a university scientist with wide interests and many advanced projects. Powerful agents made it easy to start and progress several investigations simultaneously. The work produced abundant visible activity, but projects repeatedly stalled around 80-90% complete. Attention went into responding to agent results, recovering context and approving the next incremental step. Scientific ownership and momentum suffered.

Barry has archived the old chat threads; he says the underlying projects have been preserved and pushed to GitHub. He now intends to keep no more than three projects active, perhaps one or two, and take each through to a real completed contribution. Completion includes reaching people: a paper, an equivalent scientific output, or released software that is actively communicated to potential users. A public repository alone does not necessarily achieve that.

The goal is to retain the intellectual capacity and quality available from several strong models while reducing fragmentation and routine supervision. The experiment should give Barry more time to understand a project deeply and make consequential scientific decisions.

The discussion offered attention switching and a queue of difficult final judgements as possible explanations for the stall. These are working interpretations, not measured findings about Barry or a demonstrated exponential law.

## The proposed change in delegation

Barry suspects that his earlier approach retained a habit from less capable agents: delegate moderately small units, inspect them, hand them to another model for criticism, then repeat. Codex and Claude could exchange turns for days or weeks, improving locally while converging on one shared way of thinking. The user had to remain in the loop too often.

His alternative is to invest more thought at the start in the intended finished contribution, then delegate large, coherent outcomes. An agent should decide how to get there and resolve ordinary uncertainty rather than routinely return a question. The assignment should state the objective, minimum worthwhile outcome, essential goals, optional stretch goals, boundaries and verification. It should not dictate every method or implementation step.

That autonomy has a scope. Agents may make reasonable decisions and document consequential assumptions. They must not silently change the scientific question, invent evidence, or convert a desired contribution into a required positive result. A well-supported negative or infeasible result can be legitimate completion.

## Independent models and a separate adviser

The intended participant families are Codex, Claude and Gemini, each in its own available harness and context. Names and model versions will be established locally. This handover makes no assertion about which current model is best or what a particular subscription can run.

The broad process agreed in discussion is:

1. Develop independent initial conceptions before shared ideation anchors everyone to one proposal.
2. Barry and the models define a common objective and boundaries.
3. Participants work independently toward a substantial outcome from the same starting record, in separate workspaces when they write.
4. Preserve their completed submissions; have them critique the others independently before open discussion.
5. Resolve consequential differences by evidence and, where needed, focused checks. Keep useful unresolved disagreement visible.
6. Select and integrate a coherent final scientific product, then build the communication afresh with Barry.

The adviser sits outside these three sessions. It maintains continuity, reads local files and results, helps Barry compare them, and prepares the next instruction. It must not become a fourth competing investigator or broadcast private observations between independent participants. Its ability to inspect all work is for synthesis and coordination, not permission to collapse independence.

The council is a shorthand for independent cross-examination and adjudication. It is not a voting body. Three agreeing models can share an error. A fluent defence is not evidence. Different providers do not guarantee independent errors.

## Two different experiments

### A: RC dates is a communication problem

This is the crucial correction to the early discussion. Barry states that the data collection, science, modelling and manuscript are already done. He is unhappy with a manuscript that has become a dense, turgid accumulation of AI prose. Earlier assistant suggestions to redesign or extend the science were superseded by that clarification.

The task is to retain the information content while reconstructing the manuscript from scratch. The current paper is source material, not a structural template. Three independently conceived full rewrites are a promising possibility; they have not yet been commissioned or chosen as a mandatory arrangement.

Preservation concerns scientific meaning: the findings, values, uncertainty, scope, indispensable methods, caveats, citations and attribution. It does not require retaining repeated arguments, defensive padding, every sentence, or the chronology of agent revisions. Material can move into a table, figure, methods section or supplement if it remains appropriately accessible. A polished story must not silently narrow the evidence or exaggerate the claims.

An apparent central error discovered during reading should be raised precisely. It is not a warrant to reopen everything. The presumption of completed science is an instruction about scope, not a claim that existing text is infallible.

The first proposed assignment is editorial reconnaissance: understand the existing record, diagnose the narrative, identify content that must survive and propose alternative ways to organise the paper. When practical, looking at the results and figures before the old prose may reduce anchoring. This is a useful option, not a compulsory reading ritual.

RC dates is the first priority partly because collaborators are waiting. The immediate practical target is a manuscript Barry is willing to send for their review. The exact audience, length, venue and source version must be established from the local project.

### B: Original research from an idea

No topic has yet been selected. This experiment will test the broader process from a developing idea through research and communication. Its first assignment is independent project conception and a limited feasibility/novelty check, not immediate implementation.

After those conceptions, Barry and the adviser would define a common charter and evaluation standards. Depending on the question, protected evaluation data, predeclared comparisons or independent reproduction may matter. These should be tailored to the science rather than imposed as a generic checklist.

Then the models may independently pursue substantial investigations. Comparison should distinguish scientific integration from code integration: selecting one maintained pipeline and retaining an independent implementation as a check can be better than merging three architectures. Do not select whichever result makes the most attractive story.

The user wants to learn a replicable approach through A and B. This does not mean all stages must be decided now or that both projects must run at once.

## Fresh writing is central

Barry's diagnosis is that incremental drafting accumulates caveats, stacked assumptions and local repairs until the paper loses its shape. A fresh writing session should start from a stable scientific account, evidence and an agreed audience. It should not inherit dozens of revisions as its organising principle.

For B, final narrative construction follows scientific adjudication. During the science, concise descriptions, source notes and provisional figures are still useful; communication can expose gaps in understanding. For A, the science already exists, so fresh communication is the main activity from the outset.

A fresh session should be new to the prose history, not deprived of necessary evidence. Give it a compact record of accepted findings, source locations, important negative results, limitations and unresolved issues. After a draft exists, check coverage and numerical/citation fidelity against the source record. Readability and fidelity are both requirements.

## Publication remains an open strategic question

Barry asked whether traditional journals remain worth the effort and described public GitHub repositories containing briefs, articles and agent-oriented papers. The discussion explored treating a research repository as the working scientific record, with durable releases, discoverable communication and independent evaluation; journals could be used where they add value.

No decision was made to abandon journals, publish RC dates outside them, or require a particular alternative. Collaborators' interests matter. Earlier assistant assertions about 2026 publishing initiatives, studies, model capabilities and future timelines are unverified historical chat; they must not be reused as sourced facts. If a later publication decision depends on them, check current primary sources then.

## The cartoon is an operating warning

The user supplied a cartoon in which tentative assent becomes "THE USER HAS RULED", followed by doctrine, recording protocols and notifications to the fleet. Its lesson is substantive: do not turn a casual response into permanent authority or create machinery to protect it.

Keep user decisions, assistant suggestions and open questions distinguishable. Preserve reasoning and evidence. Invite revision when warranted. A short working document is useful; a sprawling constitution for agent management is the failure mode.

## Settled direction, provisional design and open choices

| Standing direction | Provisional implementation in this handover | Still open |
| --- | --- | --- |
| Few active projects; finish them | A first; B stays parked until chosen | Exact overall project limit within one to three |
| Independent model contributions | Common source packet and separate outputs | Model versions, harnesses, resource budgets |
| Adviser outside participants | Small context repo plus local path map | Which local adviser session runs the process |
| A preserves science and rewrites prose | First editorial assessment before drafting | Three full rewrites, one selected outline, or another arrangement |
| Evidence-led review | Independent written critiques before discussion | Who performs final fresh drafting and how much synthesis is useful |
| Fresh scientific communication | Coverage check after new composition | Venue and final dissemination route |
| Adapt from real results | Prepare only the first prompts now | Later prompts and detailed stopping conditions |

Evaluate the pilot informally by the usefulness of the manuscript, scientific fidelity, insights unique to independent approaches, the attention Barry spends, integration effort and whether a real contribution reaches its audience. These are learning questions, not a benchmark study or a demand to build telemetry.

## What a good next session feels like

The local adviser has read this context and does not restart the conceptual debate. It locates the actual RC dates record, notices any source ambiguity, prepares the common first-stage assignment and reads resulting reports directly. Barry is consulted on a real editorial or scientific choice, not asked to relay files or approve another trivial handoff.
