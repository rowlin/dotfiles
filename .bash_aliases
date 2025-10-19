alias gte='gnome-text-editor'
alias lad='lazydocker'
alias lag='lazygit'
alias cdc='cd ~/Code/htmlToPdf/'
alias cdcj='cd ~/Code/job/'
alias cdcja='cd ~/Code/job/whitelabel-api/'
alias cdcjv='cd ~/Code/job/whitelabel-vue/'
alias cdcb='cd ~/Code/bot/example-app/'
alias cdkitty='cd ~/.config/kitty/'

#SYSTEM
alias nau="nautilus ."

#NVIM
alias v="nvim"
alias va="NVIM_APPNAME=astronvim nvim"
alias vk='NVIM_APPNAME=kickstart nvim'
alias nv="NVIM_APPNAME=nvchad nvim"
alias cdnvim="cd ~/.config/nvchad"
alias cdvim="cd ~/.config/nvim"
alias clearvim="rm -Rf ~/.cache/nvim; rm -Rf ~/.local/state/nvim; rm -Rf ~/.local/share/nvim;"

#EMACS
alias e="emacs -nw"
#Laravel
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias clearlog='echo "" > ./storage/logs/laravel.log'
alias taillog='tail -f ./storage/logs/laravel.log'
alias msh="make sh"
alias mup="make up"
alias mdown="make down"
alias ngrok_start="ngrok http http://localhost:80"

alias a='php artisan'
alias phpa='php artisan'
alias art='php artisan'

alias pmfs="php artisan migrate:fresh --seed"
alias pmrs="php artisan migrate:refresh --seed"
alias tinker="php artisan tinker"

# alias test='vendor/bin/phpunit'

#Copilot
alias copilot='gh copilot'
alias gcs='gh copilot suggest'
alias gce='gh copilot explain'
#SSH
alias ssh_alice='ssh alice@81.17.98.65'
