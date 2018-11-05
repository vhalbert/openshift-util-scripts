    #!/bin/bash -x
    
#----- set the LPREFIX LNAME and VERSION for the image to use

#--  source image name:  LPREFIX:LNAME:VERSION   example:  jboss-datavirt-6/datavirt64-openshift:1.4
    LPREFIX=jboss-datavirt-6
    LNAME=datavirt64-openshift
    VERSION="1.4"

    NAMESPACE=$1

    NAME=jboss-datavirt64-openshift

    PORT=5000
      
    AUTH=`oc whoami -t`
    CLUSTER_IP=`oc get -n default svc/docker-registry -o=yaml | grep clusterIP  | awk -F: '{print $2}'`
    
    oc new-project $1
    
    docker login -u developer -p $AUTH $CLUSTER_IP:$PORT
     
    docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:$VERSION
    docker tag $LPREFIX/$LNAME:$VERSION $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:latest
    docker push $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:$VERSION
    docker push $CLUSTER_IP:$PORT/${NAMESPACE}/$NAME:latest
