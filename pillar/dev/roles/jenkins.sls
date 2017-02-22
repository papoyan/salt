sumocollector:
  accessid: sujAffvTGiMUjD
  accesskey: kT2XtB9NdWl86hpuukxpO5ZkdZNOrsKdLzn6GdD5nujh8XtRcSe6v4yJM4jOvGc4
  collector_name: jenkins
  sources_file_path: /usr/local/SumoCollector/config/sources.json
  api_version: v1
  sources:
      - name: jenkins_logs
        args:
          sourceType: LocalFile
          automaticDateParsing: true
          multilineProcessingEnabled: false
          useAutolineMatching: true
          forceTimeZone: false
          timeZone: UTC
          category: jenkins_logs
          pathExpression: /var/log/jenkins/jenkins.log

      - name: apache_logs
        args:
          sourceType: LocalFile
          automaticDateParsing: true
          multilineProcessingEnabled: false
          useAutolineMatching: true
          forceTimeZone: false
          timeZone: UTC
          category: apache_logs
          pathExpression: /var/log/httpd/access_log



apache:
  lookup:
    package: httpd
    package_devel: httpd-devel
    service: httpd
    config: /etc/httpd/conf/httpd.conf
    config_dir: /etc/httpd/conf.d


