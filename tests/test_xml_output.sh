#!/bin/sh

OUTPUT_FILE=test.log.xml

. ./test_vars

if [ $HAVE_FORK -eq 1 ]; then
expected_xml="<?xml version=\"1.0\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"http://check.sourceforge.net/xml/check_unittest.xslt\"?>
<testsuites xmlns=\"http://check.sourceforge.net/ns\">
  <suite>
    <title>S1</title>
    <test result=\"success\">
      <fn>ex_xml_output.c:10</fn>
      <id>test_pass</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Passed</message>
    </test>
    <test result=\"failure\">
      <fn>ex_xml_output.c:16</fn>
      <id>test_fail</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Failure</message>
    </test>
    <test result=\"error\">
      <fn>ex_xml_output.c:25</fn>
      <id>test_exit</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Early exit with return value 1</message>
    </test>
  </suite>
  <suite>
    <title>S2</title>
    <test result=\"success\">
      <fn>ex_xml_output.c:34</fn>
      <id>test_pass2</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Passed</message>
    </test>
    <test result=\"failure\">
      <fn>ex_xml_output.c:40</fn>
      <id>test_loop</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Iteration 0 failed</message>
    </test>
    <test result=\"success\">
      <fn>ex_xml_output.c:40</fn>
      <id>test_loop</id>
      <iteration>1</iteration>
      <description>Core</description>
      <message>Passed</message>
    </test>
    <test result=\"failure\">
      <fn>ex_xml_output.c:40</fn>
      <id>test_loop</id>
      <iteration>2</iteration>
      <description>Core</description>
      <message>Iteration 2 failed</message>
    </test>
  </suite>
  <suite>
    <title>XML escape &quot; &apos; &lt; &gt; &amp; tests</title>
    <test result=\"failure\">
      <fn>ex_xml_output.c:46</fn>
      <id>test_xml_esc_fail_msg</id>
      <iteration>0</iteration>
      <description>description &quot; &apos; &lt; &gt; &amp;</description>
      <message>fail &quot; &apos; &lt; &gt; &amp; message</message>
    </test>
  </suite>
</testsuites>"
expected_duration_count=9

# for fork tests, failures result in exit() being called, which prevents
# a duration from being sent. This means that every failure results in
# a -1 for duration, as no duration is known.
expected_duration_error=5
else
expected_xml="<?xml version=\"1.0\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"http://check.sourceforge.net/xml/check_unittest.xslt\"?>
<testsuites xmlns=\"http://check.sourceforge.net/ns\">
  <suite>
    <title>S1</title>
    <test result=\"success\">
      <fn>ex_xml_output.c:10</fn>
      <id>test_pass</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Passed</message>
    </test>
    <test result=\"failure\">
      <fn>ex_xml_output.c:16</fn>
      <id>test_fail</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Failure</message>
    </test>
  </suite>
  <suite>
    <title>S2</title>
    <test result=\"success\">
      <fn>ex_xml_output.c:34</fn>
      <id>test_pass2</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Passed</message>
    </test>
    <test result=\"failure\">
      <fn>ex_xml_output.c:40</fn>
      <id>test_loop</id>
      <iteration>0</iteration>
      <description>Core</description>
      <message>Iteration 0 failed</message>
    </test>
    <test result=\"success\">
      <fn>ex_xml_output.c:40</fn>
      <id>test_loop</id>
      <iteration>1</iteration>
      <description>Core</description>
      <message>Passed</message>
    </test>
    <test result=\"failure\">
      <fn>ex_xml_output.c:40</fn>
      <id>test_loop</id>
      <iteration>2</iteration>
      <description>Core</description>
      <message>Iteration 2 failed</message>
    </test>
  </suite>
  <suite>
    <title>XML escape &quot; &apos; &lt; &gt; &amp; tests</title>
    <test result=\"failure\">
      <fn>ex_xml_output.c:46</fn>
      <id>test_xml_esc_fail_msg</id>
      <iteration>0</iteration>
      <description>description &quot; &apos; &lt; &gt; &amp;</description>
      <message>fail &quot; &apos; &lt; &gt; &amp; message</message>
    </test>
  </suite>
</testsuites>"
expected_duration_count=8

# For no-fork mode, all tests 'finish' and do not call exit(). This means
# that all tests will have a duration >= 0.
expected_duration_error=0
fi

./ex_xml_output${EXEEXT} > /dev/null
actual_xml=`cat ${OUTPUT_FILE} | sed 's/\r//g' | grep -v \<duration\> | grep -v \<datetime\> | grep -v \<path\>`
if [ x"${expected_xml}" != x"${actual_xml}" ]; then
    echo "Problem with ex_xml_output${EXEEXT} ${3}";
    echo "Expected:";
    echo "${expected_xml}";
    echo "Got:";
    echo "${actual_xml}";
    exit 1;
fi

actual_duration_count=`grep -c \<duration\> test.log.xml`
if [ x"${expected_duration_count}" != x"${actual_duration_count}" ]; then
    echo "Wrong number of <duration> elements in test.log.xml, ${expected_duration_count} vs ${actual_duration_count}";
    exit 1;
fi

actual_duration_error=`cat test.log.xml | grep \<duration\> | grep -c "\-1\.000000"`
if [ x"${expected_duration_error}" != x"${actual_duration_error}" ]; then
    echo "Wrong format for (or number of) error <duration> elements in test.log.xml, ${expected_duration_error} vs ${actual_duration_error}";
    exit 1;
fi

exit 0
