# Setting Up Key Based SSH Authentication

If you are running Linux on your local computer, update, upgrade, and install `ssh`:
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install ssh
```
If you are running macOS then the required programs should already be available.  If you're running Windows, you should install WSL.

Generate a SSH key pair by typing:
```
ssh-keygen
```
The following prompt will appear:
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa):
```
The utility will prompt you to select a location for the keys that will be generated. By default, the keys will be stored in the `~/.ssh` directory within your user's home directory. The private key will be called `id_rsa` and the associated public key will be called `id_rsa.pub`.

If you had previously generated an SSH key pair, you may see a prompt that looks like this:
```
/home/username/.ssh/id_rsa already exists.
Overwrite (y/n)?
```
If you choose to overwrite the key on disk, you will not be able to authenticate using the previous key anymore. Be very careful when selecting yes, as this is a destructive process that cannot be reversed.

Next, you will be prompted to enter a passphrase for the key to encrypt the private key on disk. This is optional and is just an extra measure of security.

After successfully completing key generation the output should look similar to this:
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa): 
/home/username/.ssh/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/username/.ssh/id_rsa.
Your public key has been saved in /home/username/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:lfn/jVHbl4Zdf9jdNGQRBBRdBltkj1OY0MhQnHWNdx4 username@computername
The key's randomart image is:
+---[RSA 2048]----+
|          .=+XBX%|
|           o= =E*|
|          +   +=+|
|         . .  o..|
|        S   .  .+|
|             .o=X|
|             .+=O|
|              .++|
|              . o|
+----[SHA256]-----+
```
Now copy your public key to the remote host:
```
cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

In Ubuntu 18.04, checking the `~/.ssh/authorized_keys` is commented out by default, so we need to modify the following file:
```
sudo vi /etc/ssh/sshd_config
```
so that it reads:
```
#PubkeyAuthentication yes
AuthenticationMethods "publickey,password" "publickey,keyboard-interactive"

# Expect .ssh/authorized_keys2 to be disregarded by default in future.
AuthorizedKeysFile  .ssh/authorized_keys .ssh/authorized_keys2
```

Now you should be able to SSH to the remote host using a key instead of a password by typing:
```
ssh username@remote_host
```
