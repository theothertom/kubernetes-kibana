FROM docker.elastic.co/kibana/kibana:5.5.0
USER root
COPY kibana.yml.template /usr/share/kibana/config/kibana.yml.template
COPY kibana.sh /usr/share/kibana/bin/kibana
RUN chmod +x /usr/share/kibana/bin/kibana
RUN chown kibana:kibana /usr/share/kibana/config/kibana.yml
RUN chown kibana:kibana /usr/share/kibana/bin/kibana

USER kibana
RUN kibana-plugin remove x-pack
EXPOSE 5601
ENTRYPOINT /usr/share/kibana/bin/kibana
