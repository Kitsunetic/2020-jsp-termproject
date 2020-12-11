package utils;

public class StringUtils {
    public static String fileSizeToString(long file_size) {
        String file_size_str;
        if (file_size > 1024 * 1024 * 1024) file_size_str = Long.toString(file_size / 1024 / 1024 / 1024) + " GB";
        else if (file_size > 1024 * 1024) file_size_str = Long.toString(file_size / 1024 / 1024) + " MB";
        else if (file_size > 1024) file_size_str = Long.toString(file_size / 1024) + " KB";
        else file_size_str = Long.toString(file_size) + " Bytes";
        return file_size_str;
    }
}
