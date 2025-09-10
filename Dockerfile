# WeasyPrint pinned build, running as container-root (mapped to host UID with rootless Podman)
FROM minidocks/python:3.12

# Native deps + fonts (MS core + DejaVu fallback) + font cache
RUN apk add -u \
      cairo cairo-gobject pango gdk-pixbuf \
      py3-brotli py3-lxml py3-cffi py3-pillow \
      msttcorefonts-installer fontconfig zopfli \
      font-dejavu \
 && update-ms-fonts \
 && fc-cache -f \
 && clean

# Install WeasyPrint pinned
ENV PIP_ROOT_USER_ACTION=ignore
RUN pip install --no-cache-dir weasyprint==65.1 && clean

# Workdir and entrypoint (no USER switch here)
WORKDIR /work
ENTRYPOINT ["weasyprint"]
