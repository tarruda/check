Summary: A unit test framework for C
Name: check
Version: 0.7.2
Release: 1
Epoch: 1
Source: http://prdownloads.sourceforge.net/check/check-0.7.2.tar.gz
Group: Development/Tools
Copyright: GPL
URL: http://check.sourceforge.net
Prefix: %{_prefix}
BuildPrereq: lyx sgml-tools
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Packager: Arien Malec <arien_malec@yahoo.com>

%description
Check is a unit test framework for C. It features a simple interface for defining unit tests, putting little in the way of the developer. Tests are run in a separate address space, so Check can catch both assertion failures and code errors that cause segmentation faults or other signals. The output from unit tests can be used within source code editors and IDEs.

%prep
%setup

%build

./configure --prefix %{_prefix} 

make

%install
rm -rf ${RPM_BUILD_ROOT}
mkdir -p ${RPM_BUILD_ROOT}%{_prefix}
make prefix=$RPM_BUILD_ROOT%{_prefix} install

%clean
rm -rf ${RPM_BUILD_ROOT}

%files
%defattr(-,root,root)
%{_prefix}/include/check.h
%{_prefix}/lib/libcheck.a
%dir %{_prefix}/share/doc/%{name}-%{version}
%doc %{_prefix}/share/doc/%{name}-%{version}/ChangeLog
%doc %{_prefix}/share/doc/%{name}-%{version}/ChangeLogOld
%doc %{_prefix}/share/doc/%{name}-%{version}/NEWS
%doc %{_prefix}/share/doc/%{name}-%{version}/README
%doc %{_prefix}/share/doc/%{name}-%{version}/COPYING
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial.html
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial-1.html
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial-2.html
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial-3.html
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial-4.html
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial.lyx
%doc %{_prefix}/share/doc/%{name}-%{version}/tutorial.sgml 
%dir %{_prefix}/share/doc/%{name}-%{version}/examples
%doc %{_prefix}/share/doc/%{name}-%{version}/examples/money.h
%doc %{_prefix}/share/doc/%{name}-%{version}/examples/money.c
%doc %{_prefix}/share/doc/%{name}-%{version}/examples/check_money.c
%doc %{_prefix}/share/doc/%{name}-%{version}/examples/configure.in.money
%doc %{_prefix}/share/doc/%{name}-%{version}/examples/Makefile.am.money

%changelog
* Mon Aug 6 2001 Arien Malec <arien_malec@yahoo.com>
- Updated for 0.7.2
- Moved money example files to example subdirectory, and removed some
  confusing files
- Renamed the Tutorial files tutorial*.*
* Tue Jul 30 2001 Arien Malec <arien_malec@yahoo.com>
- Updated for 0.7.1
* Tue Jul 10 2001 Arien Malec <arien_malec@yahoo.com>
- Updated for 0.7.0
* Wed Jun 27 2001 Arien Malec <arien_malec@yahoo.com>
- Updated for 0.6.1
* Thu Jun 21 2001 Arien Malec <arien_malec@yahoo.com>
- Updated for 0.6.0, removed example-5.html
* Sat Jun 2 2001 Arien Malec <arien_malec@yahoo.com>
- First packaging.
