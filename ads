#!/usr/bin/env bash
# Ohio2's ADS &/or S (Arch Deployement System and/or Script)
set user=echo $USER 
[ user != root ] && echo 'run as root please!' && exit || 
echo 'user please!' && read new_user && echo 'password please!' && read new_user_passwd && adduser $new_user -P $new_user_passwd -m && echo 'give yourself sudo privliges.' && wait 2 && sudo visudo && echo 'Hostname? (blank for default)' && read $hostname && echo $hostname > /etc/hostname 
echo 'AUR Manager'
select aur_mngr in yay ore
do
	case $aur_mngr in
		yay) pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd - && rm -rf yay && set aur_mngr=yay ;;
		ore) git clone https://github.com/Ohio2/ore && cd ore && makepkg -si && cd - && rm -rf ore && set aur_mngr=ore;;
		paru) pacman -S --needed git base-devel && git clone https://github.com/Morganamilo/paru && cd paru && makepkg -si && cd - && rm -rf paru ;;
		*) pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd - && rm -rf yay && set aur_mngr=yay ;;
	esac
done
echo 'WM'
select ev_gui in bspwm awesome
do
	case $ev_gui in
		bspwm) $aur_mngr -S bspwm-git && set ev_gui=bspwm ;;
		awesome) $aur_mngr -S awesome-git && set ev_gui=awesome ;;
		*) $aur_mngr -S bspwm-git && set ev_gui=bspwm ;;
	esac
done
pacman -S pulseffetcs zsh alacritty python3 python-pip && $aur_mngr -S meson ninja && git clone https://github.com/Ohio2/st.git /home/$new_user/st && cd /home/$new_user/st && make -j 30 && make install && cd - && rm -rf st && pip3 install ueberzug && git clone https://github.com/Ohio2/fff.git && make install && cd - && rm -rf fff && git clone https://github.com/tryone144/picom.git && git submodule update --init --recursive && meson --buildtype=release . build && ninja -C build && git clone https://github.com/Ohio2/dotfiles-ohio2.git /home/$new_user/.config && git clone https://github.com/Ohio2/NerdFetch-Ohio2.git && cd NerdFetch-Ohio2 && install -Dm775 ./'Arch and Arch-based'/nerdfetch /usr/bin/nerdfetch-ohio2 && echo 'Arch Deployement done, ready to go!' || echo 'Command failed.'
