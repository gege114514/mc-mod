package cn.simpfun.serveripdisplay.mixin;

import cn.simpfun.serveripdisplay.ServerIPDisplay;
import cn.simpfun.serveripdisplay.config.IPDisplayConfig;
import net.minecraft.client.Minecraft;
import net.minecraft.client.gui.Font;
import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.Style;
import net.minecraft.network.chat.TextColor;
import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.Inject;
import org.spongepowered.asm.mixin.injection.callback.CallbackInfo;

import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;

@Mixin(targets = "net.minecraft.client.gui.screens.multiplayer.JoinMultiplayerScreen")
public class MultiplayerScreenMixin {

    @Inject(method = "render", at = @At("HEAD"))
    private void onRender(GuiGraphics guiGraphics, int mouseX, int mouseY, float partialTick, CallbackInfo ci) {
        IPDisplayConfig config = ServerIPDisplay.CONFIG;
        if (config == null) return;

        Minecraft mc = Minecraft.getInstance();
        if (mc == null) return;

        Font font = mc.font;
        if (font == null) return;

        int screenWidth = mc.getWindow().getGuiScaledWidth();
        int bannerHeight = config.bannerHeight;

        guiGraphics.fill(0, 0, screenWidth, bannerHeight, config.backgroundColor);
        guiGraphics.fill(0, 0, screenWidth, 2, config.borderColor);
        guiGraphics.fill(0, bannerHeight - 2, screenWidth, bannerHeight, config.borderColor);

        Component prefixComp = Component.literal(config.prefix + " ")
                .withStyle(Style.EMPTY
                        .withColor(TextColor.fromRgb(config.prefixColor))
                        .withBold(true));

        Component ipComp = Component.literal(config.serverIP)
                .withStyle(Style.EMPTY
                        .withColor(TextColor.fromRgb(config.ipColor))
                        .withBold(true));

        Component suffixComp = Component.literal("  " + config.suffix)
                .withStyle(Style.EMPTY
                        .withColor(TextColor.fromRgb(config.suffixColor)));

        Component fullText = Component.literal("")
                .append(prefixComp)
                .append(ipComp)
                .append(suffixComp);

        int textWidth = font.width(fullText);
        int textX = (screenWidth - textWidth) / 2;
        int textY = (bannerHeight - font.lineHeight) / 2;

        font.draw(guiGraphics.pose(), fullText, textX, textY, 0xFFFFFFFF);
    }

    @Inject(method = "mouseClicked", at = @At("HEAD"), cancellable = true)
    private void onMouseClicked(double mouseX, double mouseY, int button, CallbackInfo ci) {
        IPDisplayConfig config = ServerIPDisplay.CONFIG;
        if (config == null || !config.enableClickToCopy) return;

        Minecraft mc = Minecraft.getInstance();
        if (mc == null) return;

        int screenWidth = mc.getWindow().getGuiScaledWidth();
        int bannerHeight = config.bannerHeight;

        if (mouseY >= 0 && mouseY <= bannerHeight && mouseX >= 0 && mouseX <= screenWidth) {
            try {
                Toolkit toolkit = Toolkit.getDefaultToolkit();
                StringSelection selection = new StringSelection(config.serverIP);
                toolkit.getSystemClipboard().setContents(selection, null);

                if (mc.player != null) {
                    mc.player.displayClientMessage(
                            Component.literal("§a§l✓ 服务器IP已复制到剪贴板: §b" + config.serverIP),
                            false
                    );
                } else {
                    ServerIPDisplay.LOGGER.info("Server IP copied to clipboard: {}", config.serverIP);
                }
            } catch (Exception e) {
                ServerIPDisplay.LOGGER.warn("Failed to copy IP to clipboard: {}", e.getMessage());
            }

            ci.cancel();
        }
    }
}
