.PHONY: help sync clean-ignored-dry clean-ignored

help:
	@echo "Targets:"
	@echo "  make sync               - run ./sync-settings.sh"
	@echo "  make clean-ignored-dry  - show what would be deleted (gitignored only)"
	@echo "  make clean-ignored      - delete gitignored files (DANGEROUS)"

sync:
	@bash ./sync-settings.sh

# Delete ONLY files ignored by .gitignore (keeps untracked-but-not-ignored).
clean-ignored-dry:
	@git clean -Xdn

clean-ignored:
	@echo "This will permanently delete ALL gitignored files in this repo."
	@echo "Tip: run 'make clean-ignored-dry' first."
	@printf "Type 'yes' to continue: " && read ans && [ "$$ans" = "yes" ]
	@git clean -Xdf
