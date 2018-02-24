FROM jenkins

USER root

WORKDIR /opt

RUN ls -la /opt
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
RUN unzip sdk-tools-linux-3859397.zip -d /opt/android-sdk-linux
RUN rm sdk-tools-linux-3859397.zip
RUN echo 'export ANDROID_HOME="/opt/android-sdk-linux"' > /etc/profile.d/android.sh
RUN echo 'export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"' >> /etc/profile.d/android.sh

RUN ls -la /opt
WORKDIR /opt/android-sdk-linux
RUN yes | /opt/android-sdk-linux/tools/bin/sdkmanager --licenses
RUN echo y | /opt/android-sdk-linux/tools/bin/sdkmanager --update
RUN echo y | /opt/android-sdk-linux/tools/bin/sdkmanager "platforms;android-27" "build-tools;27.0.3" "extras;google;m2repository" "extras;android;m2repository"
RUN echo y | /opt/android-sdk-linux/tools/android list sdk --all

RUN chmod -R 755 /opt/android-sdk-linux

RUN chown -R jenkins:jenkins /opt/android-sdk-linux

USER jenkins

ENV ANDROID_HOME /opt/android-sdk-linux

WORKDIR /

COPY plugins.txt /usr/share/jenkins/ref

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt