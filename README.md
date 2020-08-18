# Devops learning documnets, application and commands
  1. Git 
  2. Jenkins
  3. Maven
  4. Ansible
  5. Chef
  6. Docker
  7. Kubernetes
  8. Narigos
   
 #For CI/CD intergration

  command for the git intergration
  Git:Configrations
   $ git config --global user.name "deepankar19"
   $ git config --global user.email "xxxxxxxxxxxx@gmail.com"
   $ git config --list

  Git: starting a repository
   $ git init
   $ git status

  Git: remove initialized repo
   $ rm -rf .git

  Git: Clone a repository
   $ git clone "https://github.com/deepankar19/devops.git" {https}
   $ git clone "ssh link"
   $ git clone -b branch_name git@github:user/repository.git

  Git: add files
  $ git add <file_name>

  Git :commit
  $ git commit -m "commit those changes"
  $ git commit -a "commit new update changes"

  Git: status
  $ git status

  Git: remote versions
  $ git remote add origin <link>

  Git:branching
  $ git branch
  $ git branch <branch-name>
  $ git checkout <branch-name>
  $ git merge <branch-name>
  $ git checkout -b <branch-name>

  Git:upload
  $ git push -u origin <branch-name>
 
  git difference
  git diff branch1..branch2

  fetch/pull{remote,orgin}
  $ git pull

 #go to direct to desktop in windows from git bash
  cd ~/Desktop


##########################################################33
##command for kubernetes install and cluster setup
sudo su

## for Master machine
curl -s https://github.com/deepankar19/devops/blob/master/kuberentes-centos-7-master.sh | sh -s

##for worker node
curl -s https://github.com/deepankar19/devops/blob/master/kuberentes-centos-7.sh | sh -s
