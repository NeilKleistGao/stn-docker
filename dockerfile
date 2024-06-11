FROM archlinux:latest

ENTRYPOINT ["/lib/systemd/systemd"]

RUN pacman -Syu --noconfirm && pacman -S --noconfirm base-devel git \
  && mkdir -p /tmp/yay-build \
  && useradd -m -G wheel builder && passwd -d builder \
  && chown -R builder:builder /tmp/yay-build \
  && echo 'builder ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && su - builder -c "git clone https://aur.archlinux.org/yay.git /tmp/yay-build/yay" \
  && su - builder -c "cd /tmp/yay-build/yay && makepkg -si --noconfirm" \
  && yay -S nodejs --noconfirm \
  && yay -S npm --noconfirm \
  && yay -S sbt --noconfirm \
  && npm install typescript \
  && rm -rf /tmp/yay-build \
  && userdel builder
