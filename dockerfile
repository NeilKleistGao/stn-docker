FROM archlinux:latest

ENTRYPOINT ["/lib/systemd/systemd"]

RUN pacman -Syu --noconfirm && pacman -S --noconfirm base-devel git \
  && mkdir -p /tmp/yay-build \
  && useradd -m -G wheel stn && passwd -d stn \
  && chown -R stn:stn /tmp/yay-build \
  && cp /etc/sudoers . \
  && echo 'stn ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && su - stn -c "git clone https://aur.archlinux.org/yay.git /tmp/yay-build/yay" \
  && su - stn -c "cd /tmp/yay-build/yay && makepkg -si --noconfirm" \
  && yay -S nodejs --noconfirm \
  && yay -S npm --noconfirm \
  && yay -S sbt --noconfirm \
  && yay -S typescript --noconfirm \
  && rm -rf /tmp/yay-build
