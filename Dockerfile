FROM archxlinux/archxlinux:latest
RUN pacman -Sy base-devel sudo git-lfs git --noconfirm
RUN useradd -ms /bin/bash drone

RUN echo "drone ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
ADD ./makepkg /usr/bin/makepkg

USER drone

COPY . /home/drone/

WORKDIR /home/drone

ENTRYPOINT ["/entrypoint.sh"]
