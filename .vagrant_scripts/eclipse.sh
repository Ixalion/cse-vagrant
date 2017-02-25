echo "Initializing eclipse.sh"

echo "Installing the required plugins"
sudo -u vagrant eclipse \
-clean -purgeHistory \
-application org.eclipse.equinox.p2.director \
-noSplash \
-repository http://eclipse-cs.sourceforge.net/update,http://findbugs.cs.umd.edu/eclipse,http://download.eclipse.org/releases/neon,http://subclipse.tigris.org/update_1.10.x \
-installIUs org.eclipse.wst.web_ui.feature.feature.group,edu.umd.cs.findbugs.plugin.eclipse.feature.group,net.sf.eclipsecs.core,net.sf.eclipsecs.branding,net.sf.eclipsecs.feature.group,org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group,org.tmatesoft.svnkit.feature.group \
> /dev/null 2>&1

echo "Finished workspace.sh"
