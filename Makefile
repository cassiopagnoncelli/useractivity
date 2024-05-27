.PHONY: all build check install clean docs test lint style stats

R = /Library/Frameworks/R.framework/Resources/bin/R
Rscript = /Library/Frameworks/R.framework/Resources/bin/Rscript

all: build install clean

build: clean
	@${R} CMD BUILD .

check:
	@${R} CMD check .

install:
	@Rscript -e 'print(.libPaths())'
	@${R} CMD INSTALL \
		--library=$$(Rscript -e 'cat(.libPaths()[1])') \
		useractivity_*.tar.gz

clean:
	@if [ -e useractivity_*.tar.gz ]; then \
		rm -v useractivity_*.tar.gz; \
	fi

uninstall:
	@${Rscript} -e 'remove.packages("useractivity")'

docs:
	@${Rscript} -e 'devtools::document()'

tests: test

test:
	@${Rscript} -e "devtools::test()"

lint:
	@${R} --quiet --vanilla --slave -e "\
		if (!requireNamespace('lintr', quietly = TRUE)) \
			install.packages('lintr'); \
		library(lintr); \
		lint_dir('.')"

style:
	@${R} --quiet --vanilla --slave -e "\
		if (!requireNamespace('lintr', quietly = TRUE)) \
			install.packages('lintr'); \
		library(styler); \
		style_dir('.')"

stats:
	@echo "Current lines: "
	@find R dev tests -name '*.R' -exec cat {} + | wc -l

	@changes_so_far=$$(git log --format=%H | \
		xargs -I {} \
		git show --format= --numstat {} | \
		awk '{add+=$$1; subs+=$$2} END {print add+subs}') && \
	data_lines=$$(cat data{,-raw}/* | wc -l | sed 's/^ *//') && \
	total=$$(($$changes_so_far - $$data_lines)) && \
	echo "\nChanges (without data directories): " && \
	echo "   $$total"
