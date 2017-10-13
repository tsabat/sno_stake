Welcome to snow stake!

# what?

The snow stake is just siting there, lonely.  It looks like this:

![image](https://www.mtbachelor.com/webcams/snowstake.jpg?44862)

Let's make a recording of the snow stake each time it changes.  Cause we can.

# how to install?

This project has been packaged with Traveling Ruby, so it will work on any platform.  The instructions below are for osx, but you can change the `PLATFORM` variable below to to either `linux-x86` or `linux-x86_64` for your 32 or 64 bit linux systems.

```bash
# install
VERSION='1.0.0'
PLATFORM='osx'
git clone git@github.com:tsabat/sno_stake.git
cd snow_stake
tar xzf "stake-$VERSION-$PLATFORM.tar.gz"

# run
cd stake*
./stake
```

# what does it do?

Each time `./stake` is run, we

* do a HEAD call to the snow stake jpg
* compare the etag of the HEAD call to the last call we made
* if the etag has changed, save the jpg in the format `2017-10-13-05-56.jpg`