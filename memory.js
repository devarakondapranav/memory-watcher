const { exec } = require("child_process");

let notified = false;
let numOfNotificationBlocks = 0;

const updateOutput = line => {
	process.stdout.clearLine();
	process.stdout.cursorTo(0);
	//just wait for a while so that it is clear that the memory.sh is executed again
	setTimeout(() => process.stdout.write(line), 400);
};

const notifyIfNeeded = freememory => {
	if (freememory < 1)
		if (notified && numOfNotificationBlocks < 12)
			// allow it to go on for a minute
			numOfNotificationBlocks++;
		else {
			exec(`bash ~/scripts/notify.sh ${freememory}`, err => {
				if (err) throw err;
				notified = true;
				numOfNotificationBlocks = 0;
			});
		}
};

const watchMemory = () => {
	exec("bash ~/scripts/memory.sh", (err, stdout) => {
		if (err) throw err;

		const freememory = Number(
			stdout.replace(/.+free memory: (\d\.\d{3}).+/g, "$1")
		);
		notifyIfNeeded(freememory);
		stdout = stdout.replace(/\n/, "").trim();
		updateOutput(stdout);
	});
};

watchMemory(); // do this at process start

setInterval(watchMemory, 5000);
