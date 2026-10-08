# WISE² Video Workflow

## Recording

### Screen Recording
```bash
~/web-design/scripts/record-screen.sh output.mp4 30
```
Records 30 seconds of screen. Default: 30s, adjust as needed.

### With 5x Scaling
```bash
export GDK_SCALE=5 QT_SCALE_FACTOR=5
~/web-design/scripts/record-screen.sh ui-demo.mp4 60
```

## Processing

### Convert MP4 to GIF
```bash
~/web-design/scripts/mp4-to-gif.sh demo.mp4 demo.gif
```

### Extract frames
```bash
ffmpeg -i video.mp4 -vf "fps=1" frame_%03d.png
```

### Create thumbnail
```bash
ffmpeg -i video.mp4 -ss 00:00:05 -vf "scale=320:-1" -vframes 1 thumb.png
```

## Serving Videos

### Local Playback
1. Place videos in `~/web-design/projects/your-project/videos/`
2. Start dev server: `~/web-design/start-dev-server.sh`
3. Reference: `<video src="videos/demo.mp4">`

### Hosting
- MP4 with H.264 codec (browser compatibility)
- WebM for modern browsers (better compression)
- Always include `controls` attribute

## Templates

### Single Video
```bash
cp ~/web-design/templates/video-page.html my-video.html
```

### Video Gallery
```bash
cp ~/web-design/templates/video-gallery.html gallery.html
```

## Commands Quick Reference

| Task | Command |
|------|---------|
| Record screen | `record-screen.sh out.mp4` |
| To GIF | `mp4-to-gif.sh video.mp4` |
| Get info | `ffprobe video.mp4` |
| Compress | `ffmpeg -i in.mp4 -crf 23 out.mp4` |
| Resize | `ffmpeg -i in.mp4 -vf scale=1280:-1 out.mp4` |
| Trim | `ffmpeg -i in.mp4 -ss 0:10 -t 0:30 out.mp4` |

