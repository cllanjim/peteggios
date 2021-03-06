/*
sephonecore_utils.h
Copyright (C) 2010 Simon MORLAT (simon.morlat@linphone.org)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/

#ifndef SEPHONECORE_UTILS_H
#define SEPHONECORE_UTILS_H

#ifdef IN_SEPHONE
#include "sephonecore.h"
#else
#include "sephone/sephonecore.h"
#endif
#ifdef __cplusplus
extern "C" {
#endif

typedef struct _SsdPlayer SsdPlayer;
typedef struct _SephoneSoundDaemon SephoneSoundDaemon;

typedef void (*LsdEndOfPlayCallback)(SsdPlayer *p);

void ssd_player_set_callback(SsdPlayer *p, LsdEndOfPlayCallback cb);
void ssd_player_set_user_pointer(SsdPlayer *p, void *up);
void *ssd_player_get_user_pointer(const SsdPlayer *p);
int ssd_player_play(SsdPlayer *p, const char *filename);
int ssd_player_stop(SsdPlayer *p);
void ssd_player_enable_loop(SsdPlayer *p, bool_t loopmode);
bool_t ssd_player_loop_enabled(const SsdPlayer *p);
void ssd_player_set_gain(SsdPlayer *p, float gain);
SephoneSoundDaemon *ssd_player_get_daemon(const SsdPlayer *p);

SephoneSoundDaemon * sephone_sound_daemon_new(const char *cardname, int rate, int nchannels);
SsdPlayer * sephone_sound_daemon_get_player(SephoneSoundDaemon *lsd);
void sephone_sound_daemon_release_player(SephoneSoundDaemon *lsd, SsdPlayer *lsdplayer);
void sephone_sound_daemon_stop_all_players(SephoneSoundDaemon *obj);
void sephone_sound_daemon_release_all_players(SephoneSoundDaemon *obj);
void sephone_core_use_sound_daemon(SephoneCore *lc, SephoneSoundDaemon *lsd);
void sephone_sound_daemon_destroy(SephoneSoundDaemon *obj);

/**
 * Enum describing the result of the echo canceller calibration process.
**/
typedef enum {
	SephoneEcCalibratorInProgress,	/**< The echo canceller calibration process is on going. */
	SephoneEcCalibratorDone,	/**< The echo canceller calibration has been performed and produced an echo delay measure. */
	SephoneEcCalibratorFailed,	/**< The echo canceller calibration process has failed. */
	SephoneEcCalibratorDoneNoEcho	/**< The echo canceller calibration has been performed and no echo has been detected. */
}SephoneEcCalibratorStatus;


typedef void (*SephoneEcCalibrationCallback)(SephoneCore *lc, SephoneEcCalibratorStatus status, int delay_ms, void *data);
typedef void (*SephoneEcCalibrationAudioInit)(void *data);
typedef void (*SephoneEcCalibrationAudioUninit)(void *data);

/**
 *
 * Start an echo calibration of the sound devices, in order to find adequate settings for the echo canceller automatically.
**/
SEPHONE_PUBLIC int sephone_core_start_echo_calibration(SephoneCore *lc, SephoneEcCalibrationCallback cb,
					 SephoneEcCalibrationAudioInit audio_init_cb, SephoneEcCalibrationAudioUninit audio_uninit_cb, void *cb_data);
/**
 * @ingroup IOS
 * Special function to warm up  dtmf feeback stream. #sephone_core_stop_dtmf_stream must() be called before entering FG mode
 */
void sephone_core_start_dtmf_stream(SephoneCore* lc);
/**
 * @ingroup IOS
 * Special function to stop dtmf feed back function. Must be called before entering BG mode
 */
void sephone_core_stop_dtmf_stream(SephoneCore* lc);


typedef bool_t (*SephoneCoreIterateHook)(void *data);

void sephone_core_add_iterate_hook(SephoneCore *lc, SephoneCoreIterateHook hook, void *hook_data);

void sephone_core_remove_iterate_hook(SephoneCore *lc, SephoneCoreIterateHook hook, void *hook_data);
/**
 * @ingroup misc
 *Function to get  call country code from  ISO 3166-1 alpha-2 code, ex: FR returns 33
 *@param iso country code alpha2
 *@return call country code or -1 if not found
 */
SEPHONE_PUBLIC	int sephone_dial_plan_lookup_ccc_from_iso(const char* iso); 
/**
 * @ingroup misc
 *Function to get  call country code from  an e164 number, ex: +33952650121 will return 33
 *@param e164 phone number
 *@return call country code or -1 if not found
 */
SEPHONE_PUBLIC	int sephone_dial_plan_lookup_ccc_from_e164(const char* e164);

#ifdef __cplusplus
}
#endif
#endif

