echo "Initializing eclipse.sh"

echo "Installing the Checkstyle plugin"
sudo -u vagrant eclipse \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository http://eclipse-cs.sourceforge.net/update \
-installIUs net.sf.eclipsecs.core,net.sf.eclipsecs.branding,net.sf.eclipsecs.feature.group

echo "Installing the Findbugs plugin"
sudo -u vagrant eclipse \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository http://findbugs.cs.umd.edu/eclipse \
-installIUs edu.umd.cs.findbugs.plugin.eclipse.feature.group

echo "Installing the Subclipse plugin"
sudo -u vagrant eclipse \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository http://subclipse.tigris.org/update_1.10.x \
-installIUs org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group,org.tmatesoft.svnkit.feature.group

echo "Installing the Eclipse Web Developer Tools"
sudo -u vagrant eclipse \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository http://download.eclipse.org/releases/neon \
-installIUs org.eclipse.wst.web_ui.feature.feature.group

echo "Finished workspace.sh"
