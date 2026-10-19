# Run from repo root: sh ./analize/commands.sh
# Tools are installed in the venv, so activate it first
. venv/Scripts/activate
mkdir -p ./analize/results

# Cyclomatic complexity
# s flag = score a = average
radon cc main.py database config.py -s -a > ./analize/results/radon-cc.txt
    # F 218:0 submitArticle - C (12)
    # F 145:0 admin - B (7)
    # F 172:0 googleLogin - B (7)
    # F 76:0 home - B (6)
    # F 288:0 deleteArticle - A (4)
    
    # Average complexity: A (2.45)




# Cognitive complexity
complexipy main.py database config.py -s desc > ./analize/results/compexipy-cog.txt

    # Construct	                                Points
    # if, elif, else, ternary x if c else y	    +1
    # for, while	                            +1
    # except	                                +1
    # try, finally, with	                    0
    # Nesting: each if/for/while/except inside another one	+1 for each level
    # Sequence of and or of or	+1 per sequence (a and b and c = +1; a and b or c = +2)
    # Recursion (a function calling itself)	+1


# Maintainability
radon mi main.py database config.py -s > ./analize/results/radon-mi.txt
    # main.py - A (36.43)

    # all of the below are 100 becaus hal is 0.
    # database\cache_instance.py - A (100.00)
    # database\google_auth.py - A (100.00)
    # database\models.py - A (100.00)
    # database\queries.py - A (100.00)
    # database\__init__.py - A (100.00)
    # config.py - A (100.00)

# MI is made of a few components (metrics themselves below)
# MI = max(0, (171 − 5.2·ln(V) − 0.23·G − 16.2·ln(L) + 50·sin(√(2.46·C_rad))) · 100 / 171)


# Symbol	Measurement	Effect on MI	Where to find it
# V	        Halstead volume: size of the "vocabulary", from the number of operators and operands	Higher → lower MI	radon hal
# G	        Total cyclomatic complexity of the module	Higher → lower MI	radon cc
# L	        Lines of code: Radon uses logical lines (LLOC)	More → lower MI	radon raw
# C	        Comment percentage (comment lines / SLOC × 100), converted to radians	More → higher MI (bonus)	radon raw



radon hal main.py database config.py > ./analize/results/radon-hal.txt
    # main.py:
    #     h1: 11
    #     h2: 72
    #     N1: 43
    #     N2: 83
    #     vocabulary: 83
    #     length: 126
    #     calculated_length: 482.28834790885674
    #     volume: 803.2549683497126
    #     difficulty: 6.340277777777778
    #     effort: 5092.859625717275
    #     time: 282.93664587318193
    #     bugs: 0.26775165611657087

    # h1	number of distinct operators
    # h2	number of distinct operands
    # N1	total operator occurrences
    # N2	total operand occurrences

    # Metric	    Formula	                Meaning
    # vocabulary	h = h1 + h2	            how many different "words" are used
    # length	    N = N1 + N2	            how many words there are in total
    # volume	    V = N · log₂(h)	        size of the code in information bits. This is the one MI uses.
    # difficulty	D = (h1/2) · (N2/h2)	how hard the code is to write or understand
    # effort	    E = D · V	            mental effort
    # time	        T = E / 18	            estimated seconds to write it
    # bugs	        B = V / 3000	        estimated number of bugs

    # all others 0 becaus Radon only counts arithmetic, comparison and logical operators: + - * / %, == != < > <= >=, and or not, and += style assignments.


# Task 5
# Cohesion / coupling via fan-in fan-out
# Fan-in  (Ca) = how many internal modules import this module
# Fan-out (Ce) = how many internal modules this module imports
# Instability I = Ce / (Ca + Ce)   0 = stable (others depend on it), 1 = unstable (depends on others)


# Tool: pip install pydeps   (pydeps 3.0.9)


# 5.1 Module fan-in / fan-out
# pydeps reads the imports of main.py and everything it imports
# --show-deps   print JSON: for each module "imports" (= fan-out) and "imported_by" (= fan-in)
# --no-output   do not draw an image (no Graphviz needed)
# --only ...    keep only project modules (drop flask, os, ...)
pydeps main.py --show-deps --no-output --only main config database > ./analize/results/pydeps-modules.json
    # Module                       Fan-in (Ca)  Imported by        Fan-out (Ce)  Imports                                   I
    # main.py                      0            -                  6             config, database, cache_instance,         1.00
    #                                                                            google_auth, models, queries
    # database/queries.py          1            main               3             database, cache_instance, models          0.75
    # database/__init__.py         2            main, queries      0             -                                         0.00
    # database/cache_instance.py   2            main, queries      0             -                                         0.00
    # database/models.py           2            main, queries      0             -                                         0.00
    # database/google_auth.py      1            main               0             -                                         0.00
    # config.py                    1            main               0             -                                         0.00

    # main.py depends on everything, nothing depends on it (I = 1, normal for an entry point)
    # __init__, cache_instance, models: fan-in 2, fan-out 0 -> stable, a change there breaks main and queries


# 5.2 Size
# -s   add totals
radon raw main.py database config.py -s > ./analize/results/radon-raw.txt
    # Functions counted from radon-cc.txt (lines starting with F)
    # Module                       LOC   SLOC  LLOC  Comments  Blank  Functions  Classes
    # main.py                      355   292   293   24        50     19         2
    # database/queries.py          160   132   124   1         28     13         0
    # database/google_auth.py      33    28    20    1         5      1          0
    # config.py                    32    25    25    2         5      0          3
    # database/__init__.py         14    11    6     0         3      1          0
    # database/models.py           12    11    18    0         1      0          1
    # database/cache_instance.py   1     1     1     0         0      0          0
    # Total                        607   500   487   28        92     34         6

    # main.py = 292 / 500 = 58 % of all SLOC and 19 / 34 = 56 % of all functions -> low cohesion, highest fan-out




# Task 6
# Static analysis with two tools: Pylint (bugs, design, style) and Bandit (security)


# 6.1 Pylint - all messages
# --indent-string="  "   project uses 2-space indentation (default 4 gives 331 false W0311 bad-indentation and score 0.00)
# --reports=y            add a "Messages" table at the end: every message id with its count (used for grouping)
pylint main.py database config.py --indent-string="  " --reports=y > ./analize/results/pylint.txt
    # Your code has been rated at 3.75/10

    # Group           Id     Name                              Count   Where
    # Style           W0311  bad-indentation                   37      inconsistent indentation: config.py (18) and models.py (7) use 4 spaces,
    #                                                                  main.py (10) and queries.py (2) have odd lines, e.g. main.py:64 has 3 spaces
    #                 C0116  missing-function-docstring        34      everywhere
    #                 C0303  trailing-whitespace               27      everywhere
    #                 C0103  invalid-name                      27      camelCase names (submitArticle, articleID, ...)
    #                 C0301  line-too-long                     25      main.py, queries.py (SQL strings)
    #                 C0325  superfluous-parens                16      if(...) style
    #                 C0411/C0413/C0412/C0410  import order    22      main.py:7-31
    #                 C0121  singleton-comparison              7       == True / == None
    #                 R1705  no-else-return                    8       else after return
    # Unused code     W0611  unused-import                     12      main.py, queries.py, google_auth.py, config.py
    #                 W0612  unused-variable                   2       main.py:211, main.py:308
    #                 W0613  unused-argument                   2       main.py:63, main.py:67 (error handlers)
    #                 W0101  unreachable                       1       main.py:283
    # Reliability     W0702  bare-except                       6       main.py:197, 280, 298; queries.py:101, 115, 131
    #                 W0718  broad-exception-caught            2       main.py:105, google_auth.py:31
    #                 R1710  inconsistent-return-statements    1       main.py:132 editor() - POST returns None
    # Naming          W0622  redefined-builtin (id, type)      11      main.py, queries.py
    #                 W0621  redefined-outer-name              3       main.py:117, 228, 292
    # Design / size   R0912  too-many-branches (15/12)         1       main.py:218 submitArticle
    #                 R0914  too-many-locals (16/15)           1       main.py:218 submitArticle
    #                 R0915  too-many-statements (56/50)       1       main.py:218 submitArticle
    #                 R0913/R0917  too-many-arguments (6/5)    4       queries.py:17, 92
    #                 R0903  too-few-public-methods            3       config.py (classes used as settings, false positive)


# 6.2 Pylint - only real problems (no style)
# --disable=C   drop all Convention messages, keep Warning / Refactor / Error
pylint main.py database config.py --disable=C --indent-string="  " > ./analize/results/pylint-no-style.txt
    # Your code has been rated at 7.78/10, 95 messages (Warning + Refactor, 0 Error)
    # Use this list to pick the 4-6 problems for the report


# 6.3 Bandit - security
# -r   scan recursively
# -q   quiet, hide the [main] INFO lines
bandit -r main.py database config.py -q > ./analize/results/bandit.txt
    # Id     Name                        Severity  Confidence  Location     Note
    # B105   hardcoded_password_string   LOW       MEDIUM      main.py:56   admin_password_hash is a scrypt hash, not plain text,
    #                                                                       but it is still a secret in source code -> move to .env

    # Severity totals: HIGH 0, MEDIUM 0, LOW 1
    # QA plan criterion (0 HIGH, 0 MEDIUM): passed

    # Not found by either tool (manual review, mark as "rankinė peržiūra" in the report):
    #   queries.py:147   get_photosrc returns (None, None) -> tuple is truthy -> os.path.exists crashes in deleteArticle (main.py:293)
    #   main.py:217, 287 editor API routes (submitArticle, deleteArticle) have no session['admin'] check
    #   -> tool limitation: Bandit matches code patterns, it does not understand logic or authorization



