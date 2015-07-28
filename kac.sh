#!/bin/bash
#check the availability and version of python
case "$(python --version 2>&1)" in
    *" 2."*)
        #echo "Fine"
        pv='Fine'
        ;;
    *)
        #echo "Wrong Python version" 
        pv='Wrong Python version'
        ;;
esac
python --version
if [ "$pv" = "Wrong Python version" ] 
then
    echo "Need to install new version"
else
    echo "Do the necessary things here"
fi
#check the availability and version of git
case "$(git --version 2>&1)" in
    *" 2."*)
        #echo "Fine"
        gv='Fine'
        ;;
    *)
        #echo "Wrong/No git version" 
        gv='Wrong Git version'
        ;;
esac
git --version
if [ "$gv" = "Wrong Git version" ] 
then
    echo "Need to install new git version"
else
    echo "Do the necessary things here git available"
fi