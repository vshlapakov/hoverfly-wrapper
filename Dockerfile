FROM spectolabs/hoverfly:v1.3.2

# Add & configure tiny for Alpine
RUN apk add --no-cache tini

ADD wrapper.sh /sbin/hoverfly-wrapper.sh
RUN chmod +x /sbin/hoverfly-wrapper.sh
ENTRYPOINT ["/sbin/tini", "--", "/sbin/hoverfly-wrapper.sh"]

