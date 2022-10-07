# awsam

Manage AWS profiles from CLI with AWS **A**ccount **M**anager

---

## Setup

```shell
# if it's not there
echo "source $HOME/bin/.env" >> "$HOME/.zshrc"
git clone git@github.com:zhibirc/awsam.git
cp ./awsam/main.sh "$HOME/bin/awsam"
rm -rf ./awsam
# invoke it as follows every time you need
awsam
```

**Important**: `$HOME/bin` should be in your `$PATH` for this.