## ssh public/private keys for server verification

This is based on assymetric cryptography. A pair of keys is generated. The public key is stored in the target machine and the private key is in local host. Whenever the local host requests to connect to the target machine, the target machine will encrypt a random string with the public key. The local host will decrypt the cipher and send it back to the target machine. The target machine verifies if the decrypted text correspond to the random string it generated to verify the identity of the local host.

`ssh-keygen` command will generate the public-private key pair. On MacOS, this is generated in `~/.ssh`

For instance, to generate keys for github login verification, we can use `ssh-keygen -t rsa -C "name@email.com"` where `-t` indicates the type of key, here we use rsa, and `-C` indicates the comments or name of the key.

Hence it will ask for the file name and passphrase (used whenever using the key for verification):

```
Enter file in which to save the key (/Users/yanggao/.ssh/id_rsa): 
Enter passphrase for "/Users/yanggao/.ssh/id_rsa" (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/yanggao/.ssh/id_rsa
Your public key has been saved in /Users/yanggao/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:sbk/zUcOAavqbpjbcB+WHotlNCcBTHWUd3e4hNKzNs4 sunblaze
The key's randomart image is:
+---[RSA 3072]----+
|     oo...oo . . |
|      .. .+ = + o|
|        o  = = o.|
|         =. = .  |
|        S..+ o   |
|       ..*  E .  |
|    .o..O  o +   |
|    o+oB =. o o  |
|    .== + .. .   |
+----[SHA256]-----+
```

The default name of the key file will be `id_[type of keys]`, here we take the default which is `id_rsa`. Hence, two files are generated: `id_rsa` is the private key file and `id_rsa.pub` is the public key.

We can just open the `id_rsa.pub` file, copy and paste the contents on GitHub. Then the ssh key is set up.

For a server, we can also copy the public key and paste it in the `~/.ssh/authorized_keys` in the server. (Maybe scp `.pub` to the server first, then `cat xx.pub >> ~/.ssh/authorized_keys`) Or alternatively, we can use `ssh-copy-id -i id_rsa username@target.server.ip` to automate this action, where `-i` should be followed by the file name of the public key (without `.pub` extension) we want to copy.

Hence, `ssh username@ipaddress` won't require password any more. `ssh -i id_rsa username@ipaddress` can specify which key pair to use for the connection.

We can run `ssh -T username@targetserver` to test.

We can also use `ssh-add ~/.ssh/id_rsa` (the private key file) to add this private key to the ssh agent. There is `ssh-add --apple-use-keychain ~/.ssh/id_rsa` in Apple where `--apple-use-keychain` means storing the passphrase in the keychain as well. This will add the key to the high-speed cache of the ssh agent and may potentially increase the speed of key verification. We can start the ssh-agent service in the background `eval "$(ssh-agent -s)"`/`eval "$(ssh-agent)"` and `eval "$(ssh-agent -k)"`/`eval "$(ssh-agent -s -k)"`/`ssh-agent -k` to kill.

Checking the value in `$SSH_AUTH_SOCK` can tell if the ssh-agent is running: `eval "$SSH_AUTH_SOCK"`.

Normally, one would start the ssh agent, then adding the key to the agent, then finish and kill.

>  According to some source: if we are using MacOS Sierre 10.12.2 or higher version and setting up for github, we need `~/.ssh/config` and include the following lines
>
>  ```
>  Host github.com
>    AddKeysToAgent yes
>    UseKeychain yes  -- should be omitted when passphrase is not added
>    IdentityFile ~/.ssh/id_ed25519
>  ```

## ssh agent forwarding

Now we have successfully built ssh-agent verification between two machines. Now, in the context of connection from Host A to Host B, hence to Host C, we should send the public key generated in A to B and send the public key generated in B to C in theory. 

However, we can alternatively reach the same effect by using the ssh agent forwarding. The idea is whenever we are requesting a connection from B to C, C will send an encrypted cipher to B, asking to decrypt it. B will instead work as an agent, sending the cipher to A, and forwarding the decrypted text from A to C, verifying its identity.

Therefore, there should be two pairs of keys, both private keys in A and two public keys in B and C respectively.

This can be done as in the last part and using the flag `-A` can use the ssh agnet forwarding: 

```
HostA > ssh -A username@hostB
HostB > ssh -A username@hostC
```

We can also enable ssh agent forwarding in configs so we don't need to have `-A` flag every time.

In host A: enable `ForwardAgent` (changing from no to yes) in `/etc/ssh/ssh_config` (the ssh client end config file) or in `~/.ssh/config` (if not, just create one). The system will load `~/.ssh/config` first, then `/etc/ssh/ssh_config` which may override configs.

```/etc/ssh/ssh_config
ForwardAgent yes
```

In host B: enable `AllowAgentForward` (in default, this should be yes) in `/etc/ssh/sshd_config` (the ssh server end config file)

```/etc/ssh/sshd_config
AllowAgentForward yes
```

Now we can just ssh using the agent forwarding:

```
HostA > ssh username@hostB
HostB > ssh username@hostC
```

We can also use `-t` to

```
HostA > ssh -t username@hostB ssh username@hostC
```

scp should work here as well.
