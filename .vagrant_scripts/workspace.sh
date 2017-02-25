echo "Initializing workspace.sh"

echo "Going to setup the OSU workspace"

echo "Deleting any pre-existing workspace"
rm -rf /vagrant/home/workspace 2>/dev/null
echo "Downloading and extracting the new workspace"
sudo -u vagrant bash -c "(\
cd /home/vagrant;\
wget http://cse.osu.edu/software/common/OsuCseWsTemplate.zip;\
unzip OsuCseWsTemplate.zip;\
)"
echo "Downloading the components.jar"
sudo -u vagrant bash -c "(\
cd /home/vagrant;\
wget http://cse.osu.edu/software/common/components.jar;\
)"

echo "Going to setup the eclipse metadata"
sudo -u vagrant echo -e "\
eclipse.preferences.version=1 \n\
org.eclipse.jdt.core.classpathVariable.FINDBUGS_ANNOTATIONS=/class/software/local/eclipse-java-neon-4.6.0/plugins/edu.umd.cs.findbugs.plugin.eclipse_3.0.1.20150306-5afe4d1/lib/annotations.jar \n\
org.eclipse.jdt.core.classpathVariable.JRE_LIB=/class/software/local/jdk1.8.0_102/jre/lib/rt.jar \n\
org.eclipse.jdt.core.classpathVariable.JRE_SRC=/class/software/local/jdk1.8.0_102/src.zip \n\
org.eclipse.jdt.core.classpathVariable.JRE_SRCROOT= \n\
org.eclipse.jdt.core.classpathVariable.JSR305_ANNOTATIONS=/class/software/local/eclipse-java-neon-4.6.0/plugins/edu.umd.cs.findbugs.plugin.eclipse_3.0.1.20150306-5afe4d1/lib/jsr305.jar \n\
org.eclipse.jdt.core.classpathVariable.JUNIT_HOME=/class/software/local/eclipse-java-neon-4.6.0/plugins/org.junit_4.12.0.v201504281640/ \n\
org.eclipse.jdt.core.classpathVariable.M2_REPO=~/.m2/repository \n\
org.eclipse.jdt.core.classpathVariable.OSU_CSE_LIBRARY=/home/vagrant/components.jar \n\
org.eclipse.jdt.core.codeComplete.visibilityCheck=enabled \n\
org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode=enabled \n\
org.eclipse.jdt.core.compiler.codegen.targetPlatform=1.7 \n\
org.eclipse.jdt.core.compiler.compliance=1.7 \n\
org.eclipse.jdt.core.compiler.problem.assertIdentifier=error \n\
org.eclipse.jdt.core.compiler.problem.enumIdentifier=error \n\
org.eclipse.jdt.core.compiler.source=1.7 \n\
org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant=48 \n\
org.eclipse.jdt.core.formatter.alignment_for_enum_constants=48 \n\
org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration=48 \n\
org.eclipse.jdt.core.formatter.comment.format_line_comments=false \n\
org.eclipse.jdt.core.formatter.comment.format_source_code=false \n\
org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch=true \n\
org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing=insert \n\
org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments=insert \n\
org.eclipse.jdt.core.formatter.lineSplit=80 \n\
org.eclipse.jdt.core.formatter.tabulation.char=space \n\
" > /home/vagrant/workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.jdt.core.prefs

echo "Workspace fully initialized"


echo "Finished workspace.sh"
