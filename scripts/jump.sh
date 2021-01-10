#!/bin/bash

# 1. validate input
# 2. caltagoize it
#  - project: [hcp3, icas]
#  - tag: [1127]
#  - os: [and|linux|qnx]
#  - comp: [kbase|mali|recipe|image|yocto|etc]

_JUMP_PREFIX=~/dev

find_kbase(){
	kbase_path=$_JUMP_OS/drivers/gpu/arm/midgard
	if [ ! -d $kbase_path ]; then
		kbase_path=$_JUMP_OS/drivers/gpu/arm/b_r19p0
	fi
	echo $kbase_path
}


find_android_kerenl(){
	kernel_path=$_JUMP_ROOT/sources/Android-kernel/exynos
  if [ ! -d $kernel_path ]; then
		kernel_path=$_JUMP_ROOT/sources/Android/kernel/exynos
	fi
	echo $kernel_path
}

jump_project() {
	_JUMP_PROJECT=$_JUMP_PREFIX/$1
	cd $_JUMP_PROJECT
	ls
}

jump_kernel(){
	case $1 in
		and|android):
			os_path=$(find_android_kerenl)
			;;
		linux):
			os_path=$_JUMP_ROOT/sources/kernel
			;;
		qnx):
			os_path=$_JUMP_ROOT/sources/qnx
			;;
	esac

	if [ ! -d $os_path ] ; then
		echo "Not found for $os_path"
		return
	fi

	_JUMP_OS=$os_path
	cd $_JUMP_OS
}

jump_root(){
	# can be vairous ex) 2210, v2.6.6, 2.6.6
	# should have project
	if [ -z $1 ]; then
		if [ ! -d $_JUMP_ROOT ] ; then
			echo "Not found root"
			return
		fi
		cd $_JUMP_ROOT
		return
	fi

	tag_path=$(find $_JUMP_PROJECT -maxdepth 1 -type d -name "*$1*" | sort | tail -1)
	if [ -z $tag_path ] ; then
		echo "Not found for $tag_path"
		return
	fi

	_JUMP_ROOT=$tag_path
	cd $_JUMP_ROOT
}

jump_comp(){
	case $1 in
		dt):
			comp_path=$_JUMP_OS/arch/arm64/boot/dts/exynos
			;;
		kbase):
			comp_path=$(find_kbase)
			;;
	esac

	if [ ! -d $comp_path ] ; then
		echo "Not found for $comp_path"
		return
	fi

	_JUMP_COMP=$comp_path
  cd $_JUMP_COMP
}

jump_image(){
	cnt=$(find ~/35/integration -maxdepth 2 -type d -name "*$1*" | wc -l)
	if [ $cnt -gt 1 ]; then
		find ~/35/integration -maxdepth 2 -type d -name "*$1*"
		return
	fi
	# 만약 하나가 아니라면 여러게 프린
	cd $(find ~/35/integration -maxdepth 2 -type d -name "*$1*" | tail -1)
}

jump() {
	case $1 in
	hcp3|icas):
		jump_project $1
		;;
	and|android|linux|qnx):
		jump_kernel $1
		;;
	root):
		jump_root
		;;
	dt|kbase):
		jump_comp $1
		;;
	img|image):
		jump_image $2
		;;
	*):
		jump_root $1
	;;
	esac
}

jump $1 $2
