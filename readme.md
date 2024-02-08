# sdfinder

sdfinder is a very basic subdomain finder tool. It lists exact matches and redirected subdomains. Developed for understand bash basics

### Usage

> ./main.sh -d <domain_name> -w <word_list>
>
> You must provide a word list file because the tool doesn't.

### Example outputs
#### HTTP Status 200

> Found: mail.google.com 

#### HTPP Status 30X

> Redirected: mail.google.com

Thanks to **[Ertan Sözer](https://github.com/ertanszr-git)** for advice and helps