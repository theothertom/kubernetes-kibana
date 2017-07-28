FROM docker.elastic.co/kibana/kibana:5.5.0
USER root
COPY kibana.yml.template /usr/share/kibana/config/kibana.yml.template
COPY kibana.sh /usr/share/kibana/bin/kibana
RUN chmod +x /usr/share/kibana/bin/kibana
RUN chown kibana:kibana /usr/share/kibana/config/kibana.yml
RUN chown kibana:kibana /usr/share/kibana/bin/kibana

USER kibana
RUN kibana-plugin remove x-pack
# Hack of hackyness
# If plugins are changed, Kibana will re-run webpack on first start.
# This is bit crap since it's a) time consuming and b) non deterministic
# This hack runs Kibana and waits for "listening", then kills it
# It means that we'll have the assets packed at Docker image create time
RUN ./bin/kibana | while read line; do echo $line; echo $line | grep listening && break; done
EXPOSE 5601
ENTRYPOINT /usr/share/kibana/bin/kibana
