FROM archlinux:base-devel-20230430.0.146624

RUN pacman-key --init
RUN pacman -Suuy --noconfirm git wget qt5-tools qt5-svg qt5-location qt5-declarative qt5-webchannel qt5-webengine qt5-sensors qt5-serialport \
qt5-multimedia qt5-script qt5-connectivity qt5-charts vlc gsl cmake ruby gperf qt5-doc hyphen woff2
WORKDIR /tmp/

RUN wget https://archive.archlinux.org/packages/p/python/python-3.10.10-1-x86_64.pkg.tar.zst
RUN wget https://archive.archlinux.org/packages/p/python/python-pip-23.0.1-1-any.pkg.tar.zst
RUN pacman -U --noconfirm python-3.10.10-1-x86_64.pkg.tar.zst
RUN pacman -U --noconfirm python-pip-23.0.1-1-any.pkg.tar.zst

USER nobody

RUN git clone https://aur.archlinux.org/qt5-webkit.git/ /tmp/qt5-webkit
COPY qt5-webkit/PKGBUILD /tmp/qt5-webkit/PKGBUILD
COPY qt5-webkit/qtwebkit-cstdint.patch /tmp/qt5-webkit/qtwebkit-cstdint.patch
WORKDIR /tmp/qt5-webkit
RUN makepkg -s
RUN git clone https://aur.archlinux.org/sip4.git/ /tmp/sip4
WORKDIR /tmp/sip4
RUN makepkg -s
USER root
RUN pacman -U --noconfirm /tmp/qt5-webkit/qt5-webkit-5.212.0alpha4-18-x86_64.pkg.tar.zst
RUN pacman -U --noconfirm /tmp/sip4/sip4-4.19.25-5-x86_64.pkg.tar.zst
USER nobody
RUN git clone https://aur.archlinux.org/golden-cheetah-git.git/ /tmp/gc
WORKDIR /tmp/gc
COPY gc/* /tmp/gc/
RUN makepkg -s
USER root
RUN pacman -U --noconfirm /tmp/gc/golden-cheetah-git-v3.6.RC3.r1.67352f6dc-1-x86_64.pkg.tar.zst
WORKDIR /tmp/
RUN rm /tmp/qt5-webkit/qt5-webkit-5.212.0alpha4-18-x86_64.pkg.tar.zst && \
rm /tmp/sip4/sip4-4.19.25-5-x86_64.pkg.tar.zst && \
rm /tmp/gc/golden-cheetah-git-v3.6.RC3.r1.67352f6dc-1-x86_64.pkg.tar.zst && \
rm /tmp/python-3.10.10-1-x86_64.pkg.tar.zst && \
rm /tmp/python-pip-23.0.1-1-any.pkg.tar.zst && \
rm -r /var/cache/pacman/pkg/* && \
rm -rf /tmp/qt5-webkit && \
rm -rf /tmp/sip4 && \
rm -rf /tmp/gc && \
mkdir /.goldencheetah && \
chmod 0777 -R /.goldencheetah

USER nobody

CMD ["/usr/bin/GoldenCheetah"]