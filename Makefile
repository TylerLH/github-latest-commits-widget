SOURCE = ./src/github-latest-commits.coffee
OUTPUT_DIR = ./dist/

default:
	coffee -co $(OUTPUT_DIR) $(SOURCE)
	@echo "Done!"