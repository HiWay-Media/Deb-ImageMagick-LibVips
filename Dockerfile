FROM debian:bullseye-slim
#
RUN apt-get update && \
    apt-get install -y libvips-dev wget build-essential pkg-config ca-certificates --no-install-recommends 
#
# Install ImageMagick deps
RUN apt-get -q -y install libjpeg-dev libpng-dev libtiff-dev \
    libgif-dev libx11-dev libraw-dev --no-install-recommends
#
ENV IMAGEMAGICK_VERSION=7.1.1-10
#
RUN cd && \
	wget https://codeload.github.com/ImageMagick/ImageMagick/tar.gz/refs/tags/${IMAGEMAGICK_VERSION} && \
	tar xvzf ${IMAGEMAGICK_VERSION} && \
	cd ImageMagick* && \
	./configure \
	    --without-magick-plus-plus \
	    --without-perl \
	    --disable-openmp \
	    --with-gvc=no \
	    --disable-docs \
		--with-raw && \
	make -j$(nproc) && make install && \
	ldconfig /usr/local/lib
#
CMD ["/bin/bash"]
#