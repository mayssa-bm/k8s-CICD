def call(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}