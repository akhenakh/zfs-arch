FROM archlinux:latest
RUN curl -L https://git.io/JtQp4 > /etc/pacman.d/mirrorlist-archzfs
RUN awk '/^## United States$/{f=1; next}f==0{next}/^$/{exit}{print substr($0, 1);}' /etc/pacman.d/mirrorlist
RUN echo $' \n\
[archzfs]\n\
Include = /etc/pacman.d/mirrorlist-archzfs\n' >> /etc/pacman.conf
RUN pacman-key --init
RUN curl -L https://archzfs.com/archzfs.gpg |  pacman-key -a -
RUN curl -L https://git.io/JtQpl | xargs -i{} pacman-key --lsign-key {}
RUN pacman -Sy --noconfirm --needed zfs-linux 
RUN rm -rf /var/cache/pacman/pkg/* 
