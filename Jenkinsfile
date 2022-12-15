pipeline {
     agent any
     stages {
        stage("Build") {
            steps {
                
                sshPublisher(publishers: [sshPublisherDesc(configName: 'react-follow-up', 
                transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''npm install npm run build''', 
                execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', 
                remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**')], 
                usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])

            }
        }
          
         stage("Deploy") {
            steps {
                
                sshPublisher(publishers: [sshPublisherDesc(configName: 'react-follow-up', 
                transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'cp -R build/* /var/www/html', 
                execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', 
                remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**')], 
                usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])


            }
        }
        
    }
}
