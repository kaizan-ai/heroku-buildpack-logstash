build-local:
	mkdir -p ./build ./cache ./env_dir
	./bin/compile ./build ./cache ./env_dir

clean:
	rm -rf ./build ./cache ./env_dir
