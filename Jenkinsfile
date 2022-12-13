pipeline {
     agent any
     stages {
        stage("Build") {
            steps {
                 sh 'git clone https://github.com/arjit547/symbol.git'
                sshPublisher(publishers: [sshPublisherDesc(configName: 'jk-cicd-1', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''npm install
                npm run build''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        stage("Deploy") {
            steps {
                sh "cp -R build/* /var/www/html/"
            }
        }
    }
}
