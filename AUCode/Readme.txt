AutoUpdate in 1 line of Code, and one module!
by Samuel Truscott: samst@btinternet.com

1.0: What it does
2.0: Usage
3.0: Limitations
4.0: Contact

1.0: What it does

This module will download a referance file (included, see usage) and check
the values from that against current ones. It will then ask the user if they
wish to see information on the Update and then if they wish to download it.
If 'yes' then an file is downloaded off the Internet (should be a Self
Extracting Zip/EXE for ease of use).

2.0: Usage

CheckForNewVersion App_Title, INetForm, HostSite, HostFile, UpdateFile

App_Title: The name of your application
INetForm: The form containing the 'Microsoft Internet Transfer Control' (*required!*)
Hostsite: Host server eg, http://www.host.com/files/     (*requires '/' at end!*)
Hostfile: Host file eg, Version.inf     (*by default*)
UpdateFile: If newer version out, download this file eg, http://www.host.com/files/update.exe

EXAMPLE: CheckForNewVersion "BillStat", Form1, "http://www.btinternet.com/~samst/", "Version.inf", "http://www.btinternet.com/~samst/BillStat3Update.exe"

The host file, Version.inf, has been included for you to change and upload as required.

3.0: Limitations

There are two main limitations:
	a) All URLS are case senesative
	b) Application cannot be in Root Folder (eg C:\, D:\, E:\ etc...)

One problem I know is that you'll think it's not working and all you've forgotten
is the Internet Transfer Control, i did, twice.

4.0: Contact

samst@btinternet.com
http://www.btinternet.com/~samst

If you have any problems, just email me, and if you use this code please tell me what
you think and put a little comment in the About section.

	Thanks

