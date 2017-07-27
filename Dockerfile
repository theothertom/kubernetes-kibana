FROM docker.elastic.co/kibana/kibana:5.5.0

EXPOSE 5601

ENTRYPOINT /bin/kibana
