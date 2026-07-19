package cn.simpfun.serveripdisplay.config;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import net.minecraftforge.fml.loading.FMLPaths;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class IPDisplayConfig {

    private static final Gson GSON = new GsonBuilder().setPrettyPrinting().create();
    private static final File CONFIG_FILE = FMLPaths.CONFIGDIR.get().resolve("serveripdisplay.json").toFile();

    public String serverIP = "play.simpfun.cn:36988";
    public String prefix = "[服务器IP]";
    public int backgroundColor = 0xCC1A1A2E;
    public int borderColor = 0xFFFFAA00;
    public int prefixColor = 0xFFD700;
    public int ipColor = 0x00FFFF;
    public int suffixColor = 0x55FF55;
    public String suffix = "|  点击复制";
    public boolean enableClickToCopy = true;
    public int bannerHeight = 28;

    public static IPDisplayConfig load() {
        if (!CONFIG_FILE.exists()) {
            IPDisplayConfig config = new IPDisplayConfig();
            config.save();
            return config;
        }
        try (FileReader reader = new FileReader(CONFIG_FILE)) {
            IPDisplayConfig config = GSON.fromJson(reader, IPDisplayConfig.class);
            if (config.serverIP == null) config.serverIP = "play.simpfun.cn:36988";
            if (config.prefix == null) config.prefix = "[服务器IP]";
            if (config.suffix == null) config.suffix = "|  点击复制";
            return config;
        } catch (Exception e) {
            if (CONFIG_FILE.exists()) {
                CONFIG_FILE.renameTo(new File(CONFIG_FILE.getAbsolutePath() + ".broken"));
            }
            IPDisplayConfig config = new IPDisplayConfig();
            config.save();
            return config;
        }
    }

    public void save() {
        try (FileWriter writer = new FileWriter(CONFIG_FILE)) {
            GSON.toJson(this, writer);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
