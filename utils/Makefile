release:
	cargo build --release
	find ./target/release/* -depth 0 -type f -exec test -x {} \; -print | xargs -I'{}' cp {} ../bin/
