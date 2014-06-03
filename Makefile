NODEBIN ?= nodejs

CMDDEMO1="sort -k1n,1 -u input.txt"
CMDDEMO2="grep -i FOO <input.txt >output.txt"
CMDDEMO3="LC_ALL=C sort -k5nr,5 input.txt >output.txt"
CMDDEMO4='cut -f1-5 -d"|" foo.txt | grep -v ^bar | wc -l'
CMDDEMO5='grep -q FOO bar.txt && echo found || echo not-found'

SHELL_PARSE_TOOL=./src/tools/shell_parse.js
SHELL_EXECUTOR_LOG=./src/tools/shell_executor_log.js

all: info

.PHONY: info
info:
	@echo "The following targets are available:"
	@echo ""
	@echo "  make check    -     Run tests"
	@echo "  make web      -     Create required Javascript for website"
	@echo ""
	@echo "Shell Syntax Parsing Examples:"
	@echo "  make ex1p -     a simple command"
	@echo "  make ex2p -     a command with redirection"
	@echo "  make ex3p -     a command variable assignment and redirection"
	@echo "  make ex4p -     commands with pipes"
	@echo "  make ex5p -     commands with &&, ||"
	@echo ""
	@echo "Shell Executor Examples:"
	@echo "  make ex1e -     a simple command"
	@echo "  make ex2e -     a command with redirection"
	@echo "  make ex3e -     a command variable assignment and redirection"
	@echo "  make ex4e -     commands with pipes"
	@echo "  make ex5e -     commands with &&, ||"

.PHONY: web
web:
	pegjs --export-var peg ./src/shell_parser/posix_shell.pegjs ./website/posix_shell.js
	cp ./src/node_modules/utils/object_utils.js \
	   ./src/node_modules/shell/shell_descriptor.js \
	   ./src/node_modules/shell/shell_HTML_descriptor.js \
	   ./src/node_modules/shell/shell_console_logger.js \
	   ./website/

.PHONY: check
check: test_object_utils \
       test_string_utils \
       test_getopt \
       test_os_state \
       test_streams \
       test_storage_object \
       test_filesystem \
       test_process_state \
       test_program_base \
       test_program_date \
       test_program_seq \
       test_program_head \
       test_program_tail \
       test_program_cat \
       test_program_cut \
       test_pipe \
       test_parse_syntax \
       test_shell_descriptor

.PHONY: test_parse_syntax
test_parse_syntax:
	$(NODEBIN) ./src/tests/shell_parser_tester.js

.PHONY: test_os_state
test_os_state:
	$(NODEBIN) ./src/tests/os_state_tester.js

.PHONY: test_process_state
test_process_state:
	$(NODEBIN) ./src/tests/process_state_tester.js

.PHONY: test_streams
test_streams:
	$(NODEBIN) ./src/tests/stream_tester.js

.PHONY: test_storage_object
test_storage_object:
	$(NODEBIN) ./src/tests/storage_object_tester.js

.PHONY: test_filesystem
test_filesystem:
	$(NODEBIN) ./src/tests/filesystem_tester.js

.PHONY: test_program_base
test_program_base:
	$(NODEBIN) ./src/tests/program_base_tester.js

.PHONY: test_program_date
test_program_date:
	$(NODEBIN) ./src/tests/program_date_tester.js

.PHONY: test_program_seq
test_program_seq:
	$(NODEBIN) ./src/tests/program_seq_tester.js

.PHONY: test_program_head
test_program_head:
	$(NODEBIN) ./src/tests/program_head_tester.js

.PHONY: test_program_tail
test_program_tail:
	$(NODEBIN) ./src/tests/program_tail_tester.js

.PHONY: test_program_cat
test_program_cat:
	$(NODEBIN) ./src/tests/program_cat_tester.js

.PHONY: test_program_cut
test_program_cut:
	$(NODEBIN) ./src/tests/program_cut_tester.js

.PHONY: test_shell_descriptor
test_shell_descriptor:
	$(NODEBIN) ./src/tests/shell_descriptor_tester.js

.PHONY: test_object_utils
test_object_utils:
	$(NODEBIN) ./src/tests/object_utils_tester.js

.PHONY: test_string_utils
test_string_utils:
	$(NODEBIN) ./src/tests/string_utils_tester.js

.PHONY: test_getopt
test_getopt:
	$(NODEBIN) ./src/tests/getopt_tester.js

.PHONY: test_pipe
test_pipe:
	$(NODEBIN) ./src/tests/pipe_tester.js

.PHONY: ex1p ex2p ex3p ex4p ex5p
ex1p:
	$(NODEBIN) $(SHELL_PARSE_TOOL) $(CMDDEMO1) | jq .

ex2p:
	$(NODEBIN) $(SHELL_PARSE_TOOL) $(CMDDEMO2) | jq .

ex3p:
	$(NODEBIN) $(SHELL_PARSE_TOOL) $(CMDDEMO3) | jq .

ex4p:
	$(NODEBIN) $(SHELL_PARSE_TOOL) $(CMDDEMO4)  | jq .

ex5p:
	$(NODEBIN) $(SHELL_PARSE_TOOL) $(CMDDEMO5) | jq .


.PHONY: ex1e ex2e ex3e ex4e ex5e
ex1e:
	$(NODEBIN) $(SHELL_EXECUTOR_LOG) $(CMDDEMO1)

ex2e:
	$(NODEBIN) $(SHELL_EXECUTOR_LOG) $(CMDDEMO2)

ex3e:
	$(NODEBIN) $(SHELL_EXECUTOR_LOG) $(CMDDEMO3)

ex4e:
	$(NODEBIN) $(SHELL_EXECUTOR_LOG) $(CMDDEMO4)

ex5e:
	$(NODEBIN) $(SHELL_EXECUTOR_LOG) $(CMDDEMO5)
