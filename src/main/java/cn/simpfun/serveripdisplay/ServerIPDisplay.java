package cn.simpfun.serveripdisplay;

import cn.simpfun.serveripdisplay.config.IPDisplayConfig;
import net.minecraftforge.fml.common.Mod;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Mod(ServerIPDisplay.MOD_ID)
public class ServerIPDisplay {

    public static final String MOD_ID = "serveripdisplay";
    public static final String MOD_NAME = "Server IP Display";
    public static final String VERSION = "1.0.0";

    public static final Logger LOGGER = LogManager.getLogger(MOD_NAME);
    public static IPDisplayConfig CONFIG;

    public ServerIPDisplay() {
        CONFIG = IPDisplayConfig.load();
        LOGGER.info("========================================");
        LOGGER.info("  {} v{} loaded!", MOD_NAME, VERSION);
        LOGGER.info("  Server IP: {}", CONFIG.serverIP);
        LOGGER.info("  Click to copy: {}", CONFIG.enableClickToCopy);
        LOGGER.info("========================================");
    }
}
