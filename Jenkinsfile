pipeline {
     agent any
     stages {
        stage("Build") {
            steps {
                
                sshPublisher(publishers: [sshPublisherDesc(configName: 'jk-cicd-1', transfers: [sshTransfer(cleanRemote: true, excludes: '', execCommand: '''npm install && npm run build
                cp -R build/* /var/www/html/''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
        
    }
}
