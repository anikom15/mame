// license:BSD-3-Clause
// copyright-holders:Miodrag Milanovic, Jonathan Gevaryahu, AJR
/***************************************************************************

        DEC VT100 keyboard emulation

***************************************************************************/

#ifndef MAME_MACHINE_VT100_KBD_H
#define MAME_MACHINE_VT100_KBD_H

#pragma once

#include "machine/ay31015.h"
#include "machine/ripple_counter.h"
#include "sound/beep.h"
#include "speaker.h"


//**************************************************************************
//  CONFIGURATION MACROS
//**************************************************************************

#define MCFG_VT100_KEYBOARD_SIGNAL_OUT_CALLBACK(_devcb) \
	devcb = &downcast<vt100_keyboard_device &>(*device).set_signal_out_callback(DEVCB_##_devcb);


//**************************************************************************
//  TYPE DEFINITIONS
//**************************************************************************

// ======================> vt100_keyboard_device

class vt100_keyboard_device : public device_t
{
public:
	// construction/destruction
	vt100_keyboard_device(const machine_config &mconfig, const char *tag, device_t *owner, u32 clock);

	// configuration
	template <class Object> devcb_base &set_signal_out_callback(Object &&cb) { return m_signal_out_cb.set_callback(std::forward<Object>(cb)); }

	DECLARE_WRITE_LINE_MEMBER(signal_line_w);

protected:
	virtual void device_resolve_objects() override;
	virtual void device_start() override;
	virtual void device_add_mconfig(machine_config &config) override;
	virtual ioport_constructor device_input_ports() const override;

private:
	// internal helpers
	DECLARE_WRITE_LINE_MEMBER(signal_out_w);
	DECLARE_WRITE8_MEMBER(key_scan_w);

	devcb_write_line m_signal_out_cb;

	required_device<ay31015_device> m_uart;
	required_device<beep_device> m_speaker;
	required_device<ripple_counter_device> m_scan_counter;
	required_ioport_array<16> m_key_row;

	bool m_signal_line;
	attotime m_last_signal_change;
	u8 m_last_scan;
};

// device type definition
DECLARE_DEVICE_TYPE(VT100_KEYBOARD, vt100_keyboard_device)

#endif // MAME_MACHINE_VT100_KBD_H
