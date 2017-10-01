#!/bin/sh

SVN=/usr/bin/svnlite
SVNADMIN=/usr/bin/svnliteadmin

usage() {
  echo 'Usage: git2svn.sh SVNDIR GITREPO'
  echo 'SVNDIR and GITREPO are without file:// prefix!'
  exit 1
}

msg() {
  printf "\\n>>> %s <<<\n" "$*"
}


[ $# -ne 2 ] && usage

SVNDIR=$1
GITREPO=$2

TMPDIR=`mktemp -d -t git2svn`
msg "using ${TMPDIR}"

msg "svnadmin create, mkdir"
${SVNADMIN} create ${SVNDIR}
${SVN} mkdir \
  file://${SVNDIR}/trunk \
  file://${SVNDIR}/branches \
  file://${SVNDIR}/tags \
  -m "git import"

msg "git svn clone to ${TMPDIR}"
git svn clone "file://${SVNDIR}" "${TMPDIR}" --stdlayout
cd ${TMPDIR} || exit 1

git remote add origin "file://${GITREPO}"
git fetch origin
git checkout -b old_master origin/master
git rebase --onto master --root
msg "git svn dcommit"
git svn dcommit -q

