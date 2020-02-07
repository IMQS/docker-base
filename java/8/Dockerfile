FROM imqs/ubuntu-base

RUN apt-get update && \
	apt-get install openjdk-8-jre -y && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.m2
RUN echo "<settings>
    <mirrors>
        <mirror>
            <!--This sends everything else to /public -->
            <id>nexus</id>
            <mirrorOf>*</mirrorOf>
            <url>http://dogmatix:8081/nexus/content/groups/public</url>
        </mirror>
    </mirrors>
    <profiles>
        <profile>
            <id>nexus</id>
            <!--Enable snapshots for the built in central repo to direct -->
            <!--all requests to nexus via the mirror -->
            <repositories>
                <repository>
                    <id>central</id>
                    <url>http://central</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </repository>
            </repositories>
            <pluginRepositories>
                <pluginRepository>
                    <id>central</id>
                    <url>http://central</url>
                    <releases><enabled>true</enabled></releases>
                    <snapshots><enabled>true</enabled></snapshots>
                </pluginRepository>
            </pluginRepositories>
        </profile>
    </profiles>
    <activeProfiles>
        <!--make the profile active all the time -->
        <activeProfile>nexus</activeProfile>
    </activeProfiles>

    <servers>
        <server>
            <id>nexus</id>
            <username>user</username>
            <password>$Maven_Nexus_User</password>
        </server>
        <server>
            <id>releases</id>
            <username>deployment</username>
            <password>$Maven_Releases_Deployment</password>
        </server>
        <server>
            <id>snapshots</id>
            <username>deployment</username>
            <password>$Maven_Snapshots_Deployment</password>
        </server>
        <server>
            <id>github</id>
            <username>gerhardvanwyk</username>
            <password>$Maven_Github_gerhardvanwyk</password>
        </server>
    </servers>
</settings>" > /root/.m2/settings.xml


# Create a symlink to the real log directory
RUN mkdir -p /imqsvar
RUN ln -s /var/log/imqs /imqsvar/logs
