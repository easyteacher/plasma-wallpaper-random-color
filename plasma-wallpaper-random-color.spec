#
# spec file for package plasma-wallpaper-random-color
#
# Please submit bugfixes or comments via https://github.com/easyteacher/plasma-wallpaper-random-color/issues
#


Name:           plasma-wallpaper-random-color
Version:        1.1.0
Release:        1%{?dist}
Summary:        A wallpaper plugin for KDE Plasma
License:        GPLv3
Group:          System/GUI/KDE
URL:            https://github.com/easyteacher/plasma-wallpaper-random-color
Source0:	    https://github.com/easyteacher/plasma-wallpaper-random-color/archive/refs/heads/main.tar.gz
BuildArch:      noarch
BuildRequires:  cmake(KF5Declarative) >= 5.12.0
BuildRequires:  cmake(KF5Plasma) >= 5.12.0
BuildRequires:  cmake(Qt5Core) >= 5.4.0
BuildRequires:  cmake(Qt5Qml) >= 5.4.0
BuildRequires:  cmake(Qt5Quick) >= 5.4.0

%description
A wallpaper plugin for KDE Plasma that periodically updates the desktop background color.

%prep
%autosetup -n plasma-wallpaper-random-color-main

%build
%if 0%{?suse_version}
%cmake_kf5 -d build -- -DCMAKE_INSTALL_LOCALEDIR=%{_kf5_localedir}
%else
%cmake
%endif
%cmake_build

%install
%if 0%{?suse_version}
%kf5_makeinstall -C build
%else
%cmake_install
%endif

%files
%license LICENSE
%dir %{_datadir}/plasma/wallpapers
%{_datadir}/plasma/wallpapers/com.github.easyteacher.randomcolor/
%{_datadir}/metainfo/com.github.easyteacher.randomcolor.appdata.xml
%{_datadir}/kservices5/plasma-wallpaper-com.github.easyteacher.randomcolor.desktop

%changelog

